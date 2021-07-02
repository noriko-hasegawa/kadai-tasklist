class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :content
      # t.string :status
      t.references :user, foreign_key: true
      # status 必要？

      t.timestamps
    end
  end
end
