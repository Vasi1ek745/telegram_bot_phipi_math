class Main
	module Menu

		def check_message(message)
						# binding.pry
            # проверяем какое сообщение пришло обычное или callback
            if message.class == Telegram::Bot::Types::CallbackQuery
              UserChange.status_change_up(message)
              
            else
              UserChange.create_user_in_db(message) if !UserChange.check_user_exist_in_db?(message)
              UserChange.status_zero(message) if message.text == "/start"
              ExerciseMessage.exercise_number_in_list_up(message) if message.text == "/next"
          	end
		end

		def start_menu
	    	kb = []
			choose_menu = ["1. Планиметрия", "2. Векторы","3. Стереометрия","4. Вероятность простая",
				"5. Вероятность сложная","6. Уравнения","7. Найти значение выражения","8. Производная анализ",
				"9. Задача с формулой","10. Текстовая Задача","11. График функции","12. Производная", "Решать все"]
			choose_menu.each{ |x| kb << [make_button(x, x)]}
			markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
		end

		def make_button(text, callback)
			Telegram::Bot::Types::InlineKeyboardButton.new(text: text, callback_data: callback)

		end
		def choose_order
		    kb = []
			choose_menu = ["По порядку", "Нерешенные", "Случайные"]
			choose_menu.each{ |x| kb << [make_button(x, x)]}
			markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
		end
		
		module_function(
			:start_menu,
			:make_button,
			:choose_order,
			:check_message
			)

	end
end
