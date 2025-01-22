class RemoveLastMessageFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :last_message, :string
  end
end
