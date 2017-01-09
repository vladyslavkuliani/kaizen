class CreateManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :managers do |t|
      t.string :name
      t.string :last
      t.string :email
      t.string :company
      t.string :password_digest

      t.timestamps
    end
  end
end
