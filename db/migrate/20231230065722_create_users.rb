class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :first_name
      t.string :user_name
      t.timestamp :first_message_time
      t.timestamp :last_message_time
      t.string :last_message

      t.timestamps
    end
  end
end
