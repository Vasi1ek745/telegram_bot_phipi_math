class Main
	module Menu

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
			:choose_order
			)

	end
end
