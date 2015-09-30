class User < ActiveRecord::Base
  before_save { email.downcase! }

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL = /\A[\w\-+.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL },
                    uniqueness: { case_sensitive: false }
end
