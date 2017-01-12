class CreateTaskskills < ActiveRecord::Migration[5.0]
  def change
    create_table :taskskills do |t|
      t.timestamps

      t.belongs_to :task
      t.belongs_to :skill
      t.integer :hours_needed
    end
  end
end
