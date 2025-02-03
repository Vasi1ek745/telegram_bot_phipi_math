class Main
	module Autorization
		def check_user_exist_in_db?(message)
			User.find_by(user_id: message.from.id) || User.find_by(user_name: message.from.username)
		end
		def send_not_autorization_message(bot,message)
			text = "Вы не добавлены в систему. Пожалуйста обратитесь к администратору!"
			bot.api.send_message(
								chat_id: message.chat.id,
								text: text,
								)
		end

		def create_user_in_db(contact)
			  User.create(
			  			user_id: contact.user_id,
	                    status: 0
	                    )

		end
		def update_data(message)
			u = User.find_by(user_id: message.from.id) || User.find_by(user_name: message.from.username)
			
			u.update(user_name: message.from.username || "",
					 first_name: message.from.first_name || "",
					 chat_id: message.chat.id,
					 user_id: message.from.id,
					 status: u.status || 0 
				 )

		end
		module_function(
			:check_user_exist_in_db?,
			:send_not_autorization_message,
			:create_user_in_db,
			:update_data
			)
	end
end


