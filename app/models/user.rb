class User < ActiveRecord::Base

  has_many :reviews
  has_secure_password

  validates :email
    presence: true

  validates :password_digest
    presence: true
end
