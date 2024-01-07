# у каждого пользователя три статуса. 0 начало 1 выбор в меню 2 режим ответов на задачи


class Main
	module CheckMessage
		def check_user_exist_in_db?(message)
			User.find_by(user_id: message.from.id)
		end
		def them_choose(message)
			u = User.find_by(user_id: message.from.id)
			u.update(them_choose: message.data, exercise_number_in_list: 0)
		end
		def solved_task(message)
		end

		def tasks_order(message)
			u = User.find_by(user_id: message.from.id)
			u.update(tasks_order: message.data)
		end
		
		def create_user_in_db(message)

			  User.create(
			  			user_id: message.from.id,
	                    first_name: message.from.first_name, 
	                    user_name: message.from.username,
	                    first_message_time: Time.now,
	                    status: 0,
	                    chat_id: message.chat.id
	                    )

		end
		def status_change_up(message)
			u = User.find_by(user_id: message.from.id)
			u.update(status: u.status + 1)
		end
		def status_zero(message)
			u = User.find_by(user_id: message.from.id)
			u.update(status: 0)
		end
		def chat_id(message)
			User.find_by(user_id: message.from.id).chat_id
			
		end
		def status(message)
			User.find_by(user_id: message.from.id).status
		end

		module_function(
		:check_user_exist_in_db?,
		:create_user_in_db,
		:status,
		:status_change_up,
		:status_zero,
		:chat_id,
		:them_choose,
		:solved_task,
		:tasks_order
		)


	end
end