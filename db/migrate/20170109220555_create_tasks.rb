class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.string :cost
      t.string :status
      t.integer :priority_level

      t.timestamps
    end
  end
end
