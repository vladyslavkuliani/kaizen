class Developer < ApplicationRecord

  has_many :developerskills, dependent: :destroy
  has_many :skills, through: :developerskills

end
