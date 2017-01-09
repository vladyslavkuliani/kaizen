class Skill < ApplicationRecord

  has_many :developerskills, dependent: :destroy
  has_many :developers, through: :developerskills

  has_many :taskskills, dependent: :destroy
  has_many :tasks, through: :taskskills

end
