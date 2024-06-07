class Main
	module ExerciseMessage

		def photo(message, bot)
			u = User.find_by(user_id: message.from.id)
			number = u.exercise_number_in_list
			list = u.exercise_list
			e = Exercise.find_by(id: list.split(";")[number])
			if e
				SendMessage.send_photo(bot,message, e.file_id)
         	else
         		text = "Видимо все задания кончились!Вы все решили"
				SendMessage.send_message(bot,message, text)

			end

		end
		def exercise_list(message)
			u = User.find_by(user_id: message.from.id)
			number_in_ege = u.them_choose
			tasks_order = u.tasks_order
			case tasks_order
			when "По порядку"
				if number_in_ege == 0
					e = Exercise.select(:id).map{|x| x = x.id}.join(";")
				else
					e = Exercise.select(:id).where("number_in_ege = ? " , number_in_ege).map{|x| x = x.id}.join(";")
				end

			when "Нерешенные"
				if number_in_ege == 0
					e = Exercise.select(:id).map{|x| x = x.id}.join(";")
				else
					completed_e = Complete.select(:exercise_id).where("user_id = ? ", 9).map{|x| x = x.exercise_id}
					e = Exercise.select(:id).where("number_in_ege = ? " , number_in_ege)
											.where.not(id: completed_e)
											.map{|x| x = x.id}.shuffle
											.join(";")
				end				

			when "Случайные"
				if number_in_ege == 0
					e = Exercise.select(:id).map{|x| x = x.id}.join(";")
				else
					e = Exercise.select(:id).where("number_in_ege = ? " , number_in_ege).map{|x| x = x.id}.shuffle.join(";")
				end				
				
			end
			u.update(exercise_list: e)
		end
		def right_answer(message)
			u = User.find_by(user_id: message.from.id)
			number = u.exercise_number_in_list
			list = u.exercise_list
			e = Exercise.find_by(id: list.split(";")[number])
			 if e
			 	e.right_answer
			 else
			 	e
			 end
		end
		def exercise_number_in_list_up(message)
			u = User.find_by(user_id: message.from.id)
			exercise_number_in_list_up = u.exercise_number_in_list + 1
			u.update(exercise_number_in_list: exercise_number_in_list_up)
			if check_photo_id(u)
               ExerciseMessage.exercise_number_in_list_up(message)
            end
		end
		def check_photo_id(u)
			number = u.exercise_number_in_list
			list = u.exercise_list
			e = Exercise.find_by(id: list.split(";")[number])
				if e
					e.file_id.nil?
				else
					e 
				end
        end

		module_function(
			:photo,
			:right_answer,
			:exercise_number_in_list_up,
			:exercise_list,
			:check_photo_id
			)
	end
end