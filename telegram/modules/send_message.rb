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
		def send_sticker(bot, message, sticker_id)
			bot.api.send_sticker(chat_id:UserChange.chat_id(message),
                     sticker: sticker_id
                     )
		end
		module_function(
			:send_message,
			:send_sticker,
			:edit_message
			)
	end
end