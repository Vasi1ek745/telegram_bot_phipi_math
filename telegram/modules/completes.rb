class Main
	module Completes
		def add_complete_exercise(message)
			u = User.find_by(user_id: message.from.id)
			number = u.exercise_number_in_list
			exercise_id = u.exercise_list.split(";")[number].to_i
			number_in_ege = Exercise.find_by(id: exercise_id).number_in_ege
			u.completes.create(exercise_id: exercise_id, number_in_ege: number_in_ege)
		end
		def allredy_add?(message)
			u = User.find_by(user_id: message.from.id)
			number = u.exercise_number_in_list
			exercise_id = u.exercise_list.split(";")[number].to_i
			u.completes.find_by(exercise_id: exercise_id)

		end
	module_function(
		:add_complete_exercise,
		:allredy_add?
	)	
	end
end