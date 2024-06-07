# у каждого пользователя три статуса. 0 начало 1 выбор в меню 2 режим ответов на задачи


class Main
	module UserChange
		def check_last_time_message_late?(message)
			u = User.find_by(user_id: message.from.id)
			Time.now.to_f - u.updated_at.to_f > 7200 

		end
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
		
		def status_change_up(message)
			u = User.find_by(user_id: message.from.id)
			if u.status < 5
				u.update(status: u.status + 1)
			else  
				u.update(status: 0)
			end
		end
		def status_zero(message)
			u = User.find_by(user_id: message.from.id)
			u.update(status: 0)
		end
		def status_one(message)
			u = User.find_by(user_id: message.from.id)
			u.update(status: 1)
		end
		def status_five(message)
			u = User.find_by(user_id: message.from.id)
			u.update(status: 5)
		end
		def chat_id(message)
			User.find_by(user_id: message.from.id).chat_id
			
		end
		def status(message)
			User.find_by(user_id: message.from.id).status
		end

		module_function(
		:check_user_exist_in_db?,
		:status,
		:status_change_up,
		:status_zero,
		:status_five,
		:status_one,
		:chat_id,
		:them_choose,
		:solved_task,
		:tasks_order,
		:check_last_time_message_late?
		)


	end
end