class User < ActiveRecord::Base
  authenticates_with_sorcery!
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL = /\A[\w\-+.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true,
                       length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
