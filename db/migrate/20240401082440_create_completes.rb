class CreateCompletes < ActiveRecord::Migration[7.1]
  def change
    create_table :completes do |t|
      t.integer :number_in_ege
      t.integer :exercise_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
