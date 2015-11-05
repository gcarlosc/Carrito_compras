class Post < ActiveRecord::Base
  belongs_to :usuario
  has_many :attachments
  validates :titulo, presence: true, uniqueness: true

  has_attached_file :post_img, styles: { post_index: "250x350>", post_show: "250x350>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :post_img, content_type: /\Aimage\/.*\Z/
end
