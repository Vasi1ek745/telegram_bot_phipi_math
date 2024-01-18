require 'telegram/bot'
require 'httparty'

token = '6324307765:AAFxzOwjWgxcEDZR0zAU9yYlV-MekmsK0jo'

Telegram::Bot::Client.run(token) do |bot|
  # bot.listen do |message|
      f = File.open("/home/vasiliy/Изображения/2.png")
    	bot.api.upload_sticker_file(
                                  user_id:431570366,
                                  sticker: "/home/vasiliy/Изображения/2.png",
                                  sticker_format: "static"
                                  )
  # end
end

