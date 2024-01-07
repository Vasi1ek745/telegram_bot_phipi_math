require File.expand_path('../config/environment', __dir__)

require 'telegram/bot'
require_relative './modules/menu'
require_relative './modules/check_message'
require_relative './modules/exercise_message'
require_relative './modules/statistics'


class Main
  
    token = Rails.application.credentials.bot_token

    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|

            if message.class  == Telegram::Bot::Types::CallbackQuery
              CheckMessage.status_change_up(message)
              status = CheckMessage.status(message)

            else
              CheckMessage.create_user_in_db(message) if !CheckMessage.check_user_exist_in_db?(message)
              CheckMessage.status_zero(message) if message.text == "/start"
              status = CheckMessage.status(message)

            end
              case status
              # статуc 0 самое начало работы
              when 0
               markup = Menu.start_menu

                bot.api.send_message(chat_id: message.chat.id,
                                     text: 'Выбери одно или несколько заданий которые хочешь тренировать',
                                     reply_markup: markup
                                     )
            # статус 1 пользователь выбрал тему для решений нужно выбрать порядок
              when 1
                
                CheckMessage.them_choose(message)

                bot.api.edit_message_text(chat_id: CheckMessage.chat_id(message),
                                    message_id: message.message.message_id,
                                     text: "Отлично!\nВы выбрали #{message.data.split(".")[1]}.\nВ каком порядке решать? ",
                                     reply_markup: Menu.choose_order
                                    )

              # пользователь выбрал порядок и задание. Смотрим что он выбрал + повышаем статус
              when 2
                CheckMessage.tasks_order(message)
                CheckMessage.status_change_up(message)  
                ExerciseMessage.exercise_list(message)
                bot.api.send_message(chat_id:CheckMessage.chat_id(message),
                                     text: "Подготовили для вас список заданий!\nПросто отправьте правильный ответ!\nДля перехода к следующему заданию отправьте команду /next"
                                     )

                ExerciseMessage.sticker(message,bot)
                                     
              # Режим ответа на задания, проверяем ответ на правильность и в зависимости от этого посылаем сообщение
              # Плюс менюшка с пропуском задания и жалобой на задание
              when 3
                right_answer = ExerciseMessage.right_answer(message)   
                if message.text.to_f == right_answer
                  bot.api.send_message(chat_id:CheckMessage.chat_id(message),
                                       text: "Это правильный ответ! 😉" 
                                       )
                  ExerciseMessage.exercise_number_in_list_up(message)
                  ExerciseMessage.sticker(message,bot)


                else   
                  bot.api.send_message(chat_id:CheckMessage.chat_id(message),
                     text: "Это не правильный ответ! 😢\nПопробуй еще" 
                     )     
                end

              end
      end
    end


end

