class Main
	module PdfCreate
		def path_to_image
			"/home/vasiliy/Изображения/Новая папка"
		end
		def select_images
			selected_images = []
			(1..12).to_a.each do |number|

				file = Dir.glob(File.join(path_to_image, "#{number};*")).sample
				selected_images << file

			end
			selected_images
		end
		def select_images_with_number(number)
			selected_images = []
			file = Dir.glob(File.join(path_to_image, "#{number};*"))
		
		end

		def pdf_create_variant
			# Путь для шрифтов
			font_path = __dir__ + "/../lib/fonts/ARIAL.TTF"
			font_path_bold = __dir__ + "/../lib/fonts/ARIALBD.TTF"
			images = select_images
			# Создаем новый PDF-документ
			Prawn::Document.generate(__dir__ + "/../lib/pdf/случайный вариант.pdf") do

				font_families.update("Arial" => {
				normal: font_path,
				bold: font_path_bold
				})

				# Устанавливаем шрифт по умолчанию
				font "Arial"

				# Добавляем изображение в PDF
				
				images.each_with_index do |x,i|
					text "#{i+1}.", style: :bold, inline_format: true
					# Вставляем изображение с центрированием и ограничением по ширине
					image x, width: 450, position: :center, hight: 92

					move_down 10
					start_new_page if i == 3 || i == 7  
				end
			end
		end
		def pdf_create_zadanie(number)
			# Путь для шрифтов
			font_path = __dir__ + "/../lib/fonts/ARIAL.TTF"
			font_path_bold = __dir__ + "/../lib/fonts/ARIALBD.TTF"
			images = select_images_with_number(numer)
			# Создаем новый PDF-документ
			Prawn::Document.generate(__dir__ + "/../lib/Задание #{number}.pdf") do

				font_families.update("Arial" => {
				normal: font_path,
				bold: font_path_bold
				})

				# Устанавливаем шрифт по умолчанию
				font "Arial"

				# Добавляем изображение в PDF
				
				images.each_with_index do |x,i|
					text "#{i+1}.", style: :bold, inline_format: true
					# Вставляем изображение с центрированием и ограничением по ширине
					image x, width: 450, position: :center, hight: 92

					move_down 10
					start_new_page if i == 3 || i == 7  
				end
			end

		end
		def pdf_delete
			 Dir.glob(__dir__ + "/../lib/pdf/*").each do |name|
			 	File.delete(name)
			 end
						
		end

		module_function(
			:pdf_create_variant,
			:select_images,
			:path_to_image,
			:pdf_delete
			)

	end
end