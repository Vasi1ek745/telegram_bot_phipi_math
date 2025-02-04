class Main
	module Menu

		def check_message(message, bot)
						# binding.pry
            # проверяем какое сообщение пришло обычное или callback
            if message.class == Telegram::Bot::Types::CallbackQuery
              UserChange.status_change_up(message)
					              
            else
    		      if message.from.id == 431570366 && message.contact
    		      		Autorization.create_user_in_db(message.contact)
            	elsif Autorization.check_user_exist_in_db?(message)
            			Autorization.update_data(message)
            			
            			UserChange.status_zero(message) if UserChange.check_last_time_message_late?(message)
            			UserChange.last_message_time_update(message)

		              UserChange.status_zero(message) if message.text == "/start"
		              UserChange.status_one(message) if message.text == "/menu"
		              UserChange.status_five(message) if message.text == "/statistics"
		              if message.text == "/variant"
		              	PdfCreate.pdf_create
		              	SendMessage.send_document(bot,message)
		              	PdfCreate.pdf_delete
		              	UserChange.status_zero(message)  
		              end
    		          ExerciseMessage.exercise_number_in_list_up(message) if message.text == "/skip"
    		      else 
    		      	Autorization.send_not_autorization_message(bot,message)
    		      end

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
