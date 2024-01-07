require 'telegram/bot'

token = '6324307765:AAFxzOwjWgxcEDZR0zAU9yYlV-MekmsK0jo'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    	p message.sticker.file_id
  end
end