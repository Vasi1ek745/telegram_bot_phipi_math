class Main
	module ExerciseMessage
		def photo(message, bot)
			u = User.find_by(user_id: message.from.id)
			number = u.exercise_number_in_list
			list = u.exercise_list
			e = Exercise.find_by(id: list.split(";")[number])
			if e
				SendMessage.send_photo(bot,message, e.photo_id)
         	else
         		text = "Видимо все задания кончились!Вы все решили"
				SendMessage.send_message(bot,message, text)

			end

		end
		def exercise_list(message)
			u = User.find_by(user_id: message.from.id)
			number_in_ege = u.them_choose
			e = Exercise.select(:id).where("number_in_ege = ? " , number_in_ege).map{|x| x = x.id}.join(";")
			u.update(exercise_list: e)
		end
		def right_answer(message)
			u = User.find_by(user_id: message.from.id)
			number = u.exercise_number_in_list
			list = u.exercise_list
			Exercise.find_by(id: list.split(";")[number]).right_answer
		end
		def exercise_number_in_list_up(message)
			u = User.find_by(user_id: message.from.id)
			exercise_number_in_list_up = u.exercise_number_in_list + 1
			u.update(exercise_number_in_list: exercise_number_in_list_up)

		end

		module_function(
			:photo,
			:right_answer,
			:exercise_number_in_list_up,
			:exercise_list
			)
	end
end