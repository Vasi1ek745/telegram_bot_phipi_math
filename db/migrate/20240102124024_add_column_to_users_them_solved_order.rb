class AddColumnToUsersThemSolvedOrder < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :them_choose, :integer
    add_column :users, :solved_task, :string
    add_column :users, :tasks_order, :string
  end
end
