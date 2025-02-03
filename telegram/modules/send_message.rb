class Main
	module SendMessage
		def send_message(bot, message, text, reply_markup = nil)
			chat_id = message.class == Telegram::Bot::Types::CallbackQuery ?  UserChange.chat_id(message) : message.chat.id  
			bot.api.send_message(
								chat_id: chat_id,
								text: text,
								reply_markup: reply_markup
								)
		end
		def edit_message(bot, message, text, reply_markup = nil)
			bot.api.edit_message_text(
									chat_id: message.message.chat.id,
									message_id: message.message.message_id,
									text: text,
									reply_markup: reply_markup
                                    )

		end
		def send_photo(bot, message, file_id)
				bot.api.send_photo(chat_id:UserChange.chat_id(message),
                     photo: file_id
                     )

		end
		def send_document(bot,message)
				doc = Faraday::UploadIO.new(__dir__ + "/../lib/случайный вариант.pdf", "application/pdf")
				bot.api.send_document(chat_id:UserChange.chat_id(message),
                     document: doc
                     )
		end
		module_function(
			:send_message,
			:send_photo,
			:edit_message,
			:send_document
			)
	end
end