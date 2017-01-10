class Task < ApplicationRecord

  belongs_to :project

  has_many :taskskills, dependent: :destroy
  has_many :skills, through: :taskskills
  
  has_many :developertasks, dependent: :destroy
  has_many :developers, through: :developertasks
end
