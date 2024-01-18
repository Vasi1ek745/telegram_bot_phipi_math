require 'telegram/bot'

token = '6324307765:AAFxzOwjWgxcEDZR0zAU9yYlV-MekmsK0jo'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|

      # p "test"
      # f = Faraday::UploadIO.new("/home/vasiliy/Изображения/2.png", "'image/png'")
       bot.api.send_photo(
                        chat_id: message.chat.id,
                        photo: "AgACAgIAAxkBAAIBomWo7IViQ5ZSOR3sGkd7DYrYBmv8AAK71zEbo7pIScNzUve8ad8oAQADAgADeAADNAQ"
                        )
    	# bot.api.upload_sticker_file(
      #                             user_id:431570366,
      #                             sticker: f,
      #                             sticker_format: "static"
      #                             )
  end
end

