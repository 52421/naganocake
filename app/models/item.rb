class Item < ApplicationRecord
    belongs_to :genre
    has_many :order_items, dependent: :destroy
    has_many :cart_items, dependent: :destroy

    validates :is_selling, presence: true
    validates :item_image, presence: true
    validates :price, presence: true, numericality: true
    validates :description, presence: true, length: {maximum: 140, minimum: 10}
    validates :name, presence: true, uniqueness: true
    validates :genre_id, presence: true
end
