class CreateDeveloperskills < ActiveRecord::Migration[5.0]
  def change
    create_table :developerskills do |t|
      t.belongs_to :developer, index: true
      t.belongs_to :skill, index: true
      t.integer :level

      t.timestamps
    end
  end
end
