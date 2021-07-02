class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :user, :string
    # :user, 追加？
  end
end
