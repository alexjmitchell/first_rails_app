class User < ApplicationRecord
  has_many :articles
  before_save { self.email = email.downcase }
  validates :username, presence: true, uniqueness: { case_sensitive: false },
                       length: { minumum: 5, maximum: 25 }

  VALID_EMAIL_REGEX = /\A([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: { minimum: 8, maximum: 25 }
  has_secure_password
end
