class ChangeColumnExerciseRightAnswer < ActiveRecord::Migration[7.1]
  def change
    change_column :exercises, :right_answer, :text
    
  end
end
