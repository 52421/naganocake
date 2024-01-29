class Item < ApplicationRecord
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  scope :where_genre_active, -> { joins(:genre).where(genres: { is_active: true }) }
  has_one_attached :image
  has_rich_text :content

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  # validates :is_active, presence: true

  #消費税 計算メソッド
  def with_tax_price
    (price * 1.1).floor # floorを用いて小数点以下切り捨て
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
  end
end