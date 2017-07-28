class User < ApplicationRecord
  has_many :todos, dependent: :destroy

  before_save {email.downcase!}

  has_secure_password

  validates :email, :password, :nickname, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}
end
