class UpdateForeignKey < ActiveRecord::Migration[7.1]
  def change
    # remove the old foreign_key
    remove_foreign_key :completes, :users

    # add the new foreign_key
    add_foreign_key :completes, :users, on_delete: :cascade
  
  end

end
