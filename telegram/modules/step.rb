class Main
	module Step
		def steps(message, bot)
# проверяем входящее сообщение, смотрим пользователя и статус
              Menu.check_message(message)
              

              status = UserChange.status(message)
              
              case status

# статуc 0 самое начало работы, стартовое меню
              when 0
                text = 'Выбери одно или несколько заданий которые хочешь тренировать'
                markup = Menu.start_menu
                SendMessage.send_message(bot,message,text, markup)
                 

# статус 1 пользователь выбрал тему для решений нужно выбрать порядок
              when 1
                UserChange.them_choose(message)
                text = "Отлично!\nВы выбрали #{message.data.split(".")[1]}.\nВ каком порядке решать?"
                markup = Menu.choose_order
                SendMessage.edit_message(bot,message,text, markup)
# после callback status не нужно изменять он повысится сам

# статус 2 пользователь выбрал порядок и задание. Смотрим что он выбрал, повышаем статус, формируем лист заданий
# отправляем первое задание стикер
              when 2
                UserChange.tasks_order(message)
                ExerciseMessage.exercise_list(message)
                text = "Подготовили для вас список заданий!\nПросто отправьте правильный ответ!\nДля перехода к следующему заданию отправьте команду /next"
                SendMessage.send_message(bot,message,text)
                ExerciseMessage.photo(message,bot)
                UserChange.status_change_up(message)  
                                     
# Статус 3 Режим ответа на задания, проверяем ответ на правильность и в зависимости от этого посылаем сообщение
              when 3
                right_answer = ExerciseMessage.right_answer(message)   
                if message.text.to_f == right_answer

                  text = "Это правильный ответ! 😉" 
                  SendMessage.send_message(bot,message,text)
                  ExerciseMessage.exercise_number_in_list_up(message)
                  ExerciseMessage.photo(message,bot)

                else   
                  text = "Это не правильный ответ! 😢\nПопробуй еще" 
                  SendMessage.send_message(bot,message,text)
                end

              end
            end
 		module_function(:steps)		
	end
end