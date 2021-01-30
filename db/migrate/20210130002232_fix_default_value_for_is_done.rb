class FixDefaultValueForIsDone < ActiveRecord::Migration[6.0]
  def change
    change_column :todos, :is_done?, :boolean, default:false
  end
end
