class Manager < ApplicationRecord

  has_secure_password

  has_many :projects

  validates :email, length: { maximum: 255 }, presence: true, format: { with: /\w+@\w+\.\w+/}, uniqueness: true

end
