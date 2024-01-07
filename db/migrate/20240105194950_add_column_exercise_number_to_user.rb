class AddColumnExerciseNumberToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :exercise_number_in_list, :integer
  end
end
