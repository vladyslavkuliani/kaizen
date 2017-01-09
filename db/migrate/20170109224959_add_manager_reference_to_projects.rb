class AddManagerReferenceToProjects < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects, :manager, foreign_key: true
  end
end
