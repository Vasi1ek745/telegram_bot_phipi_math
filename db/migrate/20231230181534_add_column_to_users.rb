class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :chat_id, :integer
  end
end
