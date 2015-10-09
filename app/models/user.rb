class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_attached_file :photo, styles: { medium: "100x100^" },
                     convert_options: { medium: "-gravity center -extent 100x100" },
                     url:  "/assets/:class/:attachment/:id_partition/:style/:filename",
                     path: ":rails_root/app/assets/images/:class/:attachment/:id_partition/:style/:filename"
  before_save { email.downcase! }

  VALID_EMAIL = /\A[\w\-+.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 50 },
                    format: { with: VALID_EMAIL },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, confirmation: true
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :password_confirmation, presence: true
  validates_attachment :photo, content_type: { content_type: /\Aimage/ }
end
