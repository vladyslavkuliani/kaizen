class Task < ApplicationRecord

  belongs_to :project

  has_many :taskskills, dependent: :destroy
  has_many :skills, through: :taskskills
  belongs_to :developer


  has_many :developertasks, dependent: :destroy
  has_many :developers, through: :developertasks

  validates :title, presence: true
  # validates :status, presence: true
  validate :deadline_cannot_be_earlier_than_today

  def deadline_cannot_be_earlier_than_today
    if deadline.present? && deadline < Date.today
      errors.add(:deadline, "cannot be in the past")
    end
  end
end
