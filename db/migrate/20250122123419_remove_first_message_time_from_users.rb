class RemoveFirstMessageTimeFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :first_message_time, :datetime
  end
end
