class Developer < ApplicationRecord
  has_many :developerskills, dependent: :destroy
  has_many :skills, through: :developerskills
  
  has_many :developertasks, dependent: :destroy
  has_many :tasks, through: :developertasks
end
