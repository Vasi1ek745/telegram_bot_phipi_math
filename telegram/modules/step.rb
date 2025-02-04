class Main
	module Step
		def steps(message, bot)
# проверяем входящее сообщение, смотрим пользователя и статус
              Menu.check_message(message,bot)
              

              status = UserChange.status(message)
              
              case status
# Статут 0 стартовое меню
              when 0
                all_completes_in_procent = Statistics.all_completes_for_user_in_procent(message)
                all_exercise_size = Exercise.all.size
                all_completes_for_user = Statistics.all_completes_for_user(message)
                text = "Привет! \nДля выбора заданий используй /menu\nТвоя полная статистика  /statistics\nРешить случайный вариант /variant\nСейчас ты готов к ЕГЭ на #{all_completes_in_procent} %\nРешено #{all_completes_for_user} заданий из #{all_exercise_size} \nПопробуй улучшить свой результат!💪"
                SendMessage.send_message(bot,message,text)
                
# статуc 1 меню заданий
              when 1
                text = 'Выбери одно или несколько заданий которые хочешь тренировать'
                markup = Menu.start_menu
                SendMessage.send_message(bot,message,text, markup)
                 

# статус 2 пользователь выбрал тему для решений нужно выбрать порядок
              when 2
                UserChange.them_choose(message)
                text = "Отлично!\nВы выбрали #{message.data.split(".")[1]}.\nВ каком порядке решать?"
                markup = Menu.choose_order
                SendMessage.edit_message(bot,message,text, markup)
# после callback status не нужно изменять он повысится сам

# статус 3 пользователь выбрал порядок и задание. Смотрим что он выбрал, повышаем статус, формируем лист заданий
# отправляем первое задание стикер
              when 3
                UserChange.tasks_order(message)
                ExerciseMessage.exercise_list(message)
                text = "Подготовили для вас список заданий!\nПросто отправьте правильный ответ!\nДля перехода к следующему заданию отправьте команду /skip\nЕсли хотите сообщить об ошибке отправьте /error"
                SendMessage.send_message(bot,message,text)
                ExerciseMessage.photo(message,bot)
                UserChange.status_change_up(message)  
                                     
# Статус 4 Режим ответа на задания, проверяем ответ на правильность и в зависимости от этого посылаем сообщение
              when 4
                right_answer = ExerciseMessage.right_answer(message)  
                user_answer = message.text.gsub('.',',')
                if user_answer == right_answer

                  text = "Это правильный ответ! 😉" 
                  SendMessage.send_message(bot,message,text)

                  Completes.add_complete_exercise(message) if  !Completes.allredy_add?(message)
                  ExerciseMessage.exercise_number_in_list_up(message)
                  ExerciseMessage.photo(message,bot)

                elsif message.text == "/skip"

                  ExerciseMessage.exercise_number_in_list_up(message)
                  ExerciseMessage.photo(message,bot)
                elsif  message.text == "/error"
                    ExerciseMessage.error(bot, message)

                    ExerciseMessage.exercise_number_in_list_up(message)

                    text = "Спасибо что сообщили о ошибке, постараемся проверить в ближайшее время!"
                    SendMessage.send_message(bot,message, text)
                    ExerciseMessage.photo(message,bot)

                  
                else

                  text = "Это не правильный ответ! 😢\nПопробуй еще" 
                  SendMessage.send_message(bot,message,text)
                end
              when 5
                text = "Здесь собрана твоя полная статистика"
                SendMessage.send_message(bot,message,text)
                text = Statistics.main_statistics_for_each_them(message)
                SendMessage.send_message(bot,message,text)

              end
            end
 		module_function(:steps)		
	end
end