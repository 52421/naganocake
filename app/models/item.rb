class Item < ApplicationRecord
    belongs_to :genre
    has_many :order_items, dependent: :destroy
    has_one_attached :image
    has_many :cart_items, dependent: :destroy

    validates :is_selling, presence: true
    validates :image, presence: true
    validates :price, presence: true, numericality: true
    validates :description, presence: true, length: {maximum: 140, minimum: 10}
    validates :name, presence: true, uniqueness: true
    validates :genre_id, presence: true
    
    # 消費税を求めるメソッド
 def with_tax_price
  (price * 1.1).floor
 end
end
