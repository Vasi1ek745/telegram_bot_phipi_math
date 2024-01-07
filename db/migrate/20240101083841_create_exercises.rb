class CreateExercises < ActiveRecord::Migration[7.1]
  def change
    create_table :exercises do |t|
      t.string :phipi_id
      t.integer :number_in_ege
      t.string :sticker_id
      t.decimal :right_answer

      t.timestamps
    end
  end
end
