class CreateDevelopers < ActiveRecord::Migration[5.0]
  def change
    create_table :developers do |t|
      t.string :name
      t.string :email
      t.float :salary
      t.boolean :taken

      t.belongs_to :manager

      t.timestamps
    end
  end
end
