class Developer < ApplicationRecord
  has_many :developerskills, dependent: :destroy
  has_many :skills, through: :developerskills
  has_one :task

  belongs_to :manager


  validates :name, presence: true
  validates :email, length: { maximum: 255 }, presence: true, format: { with: /\w+@\w+\.\w+/}, uniqueness: true
end
