class Developer < ApplicationRecord
  has_many :developerskills, dependent: :destroy
  has_many :skills, through: :developerskills

  has_one :task

  belongs_to :manager
end
