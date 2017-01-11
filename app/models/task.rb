class Task < ApplicationRecord

  belongs_to :project

  has_many :taskskills, dependent: :destroy
  has_many :skills, through: :taskskills

  belongs_to :developer
end
