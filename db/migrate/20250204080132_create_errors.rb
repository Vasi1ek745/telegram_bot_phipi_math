class CreateErrors < ActiveRecord::Migration[7.1]
  def change
    create_table :errors do |t|
      t.integer :exercise_id
      t.string :user_name
      t.integer :user_id

      t.timestamps
    end
  end
end
