class Task < ApplicationRecord

  has_many :taskskills, dependent: :destroy
  has_many :skills, through: :taskskills

end
