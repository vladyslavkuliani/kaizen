class Project < ApplicationRecord
  belongs_to :manager
  has_many :tasks, dependent: :destroy

  validates :title, presence: true
  validate :deadline_cannot_be_earlier_than_today

  def deadline_cannot_be_earlier_than_today
    if deadline.present? && deadline < Date.today
      errors.add(:deadline, "cannot be in the past")
    end
  end
end
