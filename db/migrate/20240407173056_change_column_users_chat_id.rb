class ChangeColumnUsersChatId < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :chat_id, :bigint
  end
end
