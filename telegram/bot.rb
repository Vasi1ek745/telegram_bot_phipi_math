require File.expand_path('../config/environment', __dir__)

require 'telegram/bot'
require_relative './modules/menu'
require_relative './modules/user_change'
require_relative './modules/exercise_message'
require_relative './modules/statistics'
require_relative './modules/send_message'
require_relative './modules/step'

def log(path, e)
    r = "*"*30
    t = Time.now.strftime("%D  %H:%M " )
    File.write(path, "\n #{r} \n #{t}\n #{e}", mode: 'a')
end

loop do
  begin
    class Main
      token = Rails.application.credentials.bot_token
      Telegram::Bot::Client.run(token) do |bot|
        bot.listen do |message|
          Thread.start(message) do |message|                  
            begin
              Step.steps(message, bot)
            rescue Exception => e
              # log file for bot_logic
              log("./telegram/log/bot_logic_log.txt" , e)
            end 
          end
        end
      end 
    end     
  rescue Exception => e
     # log file for api error
      log("./telegram/log/bot_api_log.txt" , e)
  end
end
