class ChangeTableExercises < ActiveRecord::Migration[7.1]
  change_table :exercises do |t|

    t.rename :sticker_id, :file_id

  
  end
end
