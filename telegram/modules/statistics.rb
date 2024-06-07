class Main
	module Statistics
		def all_completes_for_user_in_procent(message)
			u = User.find_by(user_id: message.from.id)
			exercise_size = Exercise.all.size
			((u.completes.size.to_f/exercise_size)*100).round(2)
		end	
		def all_completes_for_user(message)
			u = User.find_by(user_id: message.from.id)
			u.completes.size
		end
		def all_exercise_in_them(number_in_ege)
			Exercise.where("number_in_ege = ? " , number_in_ege.to_i).size
		end
		def completes_exercise_in_them(message,number_in_ege)
			u = User.find_by(user_id: message.from.id)
			u.completes.where("number_in_ege = ? " , number_in_ege).size
		end
		def main_statistics_for_each_them(message)
			smile = ["🤬","🤦","🦍","🫠","🫣","🤔","😏","😌","🥰","💝","💯"]
			text = ""
			choose_menu = ["1. Планиметрия", "2. Векторы","3. Стереометрия","4. Вероятность простая",
			"5. Вероятность сложная","6. Уравнения","7. Найти значение выражения","8. Производная анализ",
			"9. Задача с формулой","10. Текстовая Задача","11. График функции","12. Производная"]
			choose_menu.each do |row|
				all_exercise = all_exercise_in_them(row.split(".")[0])
				completes_exercise_in_them = completes_exercise_in_them(message, row.split(".")[0])
				if all_exercise != 0
					procent = (completes_exercise_in_them.to_f/all_exercise * 100).round(2) 
				else
					procent = 0
				end
				smile_now = smile[(procent/10).round]
				row += " #{completes_exercise_in_them} из #{all_exercise}    #{procent}%   #{smile_now}\n"
				text+=row
			end
			text
		end


	module_function(
		:all_completes_for_user_in_procent,
		:all_completes_for_user,
		:main_statistics_for_each_them,
		:all_exercise_in_them,
		:completes_exercise_in_them

		)		
	end
end