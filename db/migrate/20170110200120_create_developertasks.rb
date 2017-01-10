class CreateDevelopertasks < ActiveRecord::Migration[5.0]
  def change
    create_table :developertasks do |t|
      t.belongs_to :task
      t.belongs_to :developer
      
      t.timestamps
    end
  end
end
