require 'telegram/bot'
require File.expand_path('../config/environment', __dir__)
require 'pry-byebug'

token = Rails.application.credentials.bot_token


def file_from_dir
    name_array = Dir.entries("/home/vasiliy/Изображения/Новая папка")
    name_array.delete(".")
    name_array.delete("..")
    name_array.map! do |screen_name|
          
          pars =  screen_name.split(";")
          number_in_ege = pars[0]
          phipi_id = pars[1]
          
          right_answer = pars[2].split(".")[0]
          screen_name = [number_in_ege, phipi_id, right_answer, screen_name]
    end
    name_array
end

Telegram::Bot::Client.run(token) do |bot|
    # binding.pry

    bot.listen do |message|
         
           
          
      if message.from.id == 431570366
        files = file_from_dir
        Exercise.last.update(file_id: message.photo[0].file_id) if message.photo
         
          file = files[0]
        while !file.nil? && Exercise.exists?(phipi_id: file[1]) 
          files.shift
          file = files[0]
        end
        
        if file
          Exercise.create(
                        number_in_ege: file[0],
                        phipi_id: file[1],
                        right_answer: file[2]
                        )
              
              f = Faraday::UploadIO.new("/home/vasiliy/Изображения/Новая папка/"+file[3], "'image/png'")

              bot.api.send_photo(
                        chat_id: message.chat.id,
                        photo: f,
                        )
        else
            bot.api.send_message(
                      text: "Кончились файлы в папке, на текущий момент #{Exercise.all.size} заданий",
                      chat_id: message.chat.id
                                  )          
            
        end
      end
      end
  end

# Логика!!! :

# 1) Делаем скрины в названии прописываем номер темы айдишник и правильный ответ
# 2) Запускаем бота
# 3) Бот смотрит всю директорию по очереди чекает файлы, если уже есть в БД то не добавляет,
#    если нету то добавляет + отправляет месседж + ждет ответ и дописывает id photo
# 4) дальше переход к следующему файлу 
