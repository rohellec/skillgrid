class Product < ActiveRecord::Base
  has_attached_file :photo, styles: { medium: "150x150>" },
                     default_url: ":style/missing.png",
                     url: "/assets/:class/:attachment/:id_partition/:style/:filename",
                     path: ":rails_root/app/assets/images/:class/:attachment/:id_partition/:style/:filename"
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true
  validates_attachment :photo, content_type: { content_type: /\Aimage/ }
end
