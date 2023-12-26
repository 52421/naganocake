class Item < ApplicationRecord
    has_many :order_items, dependent: :destroy
    has_one_attached :image
    has_many :cart_items, dependent: :destroy

    validates :image, presence: true
    validates :price, presence: true, numericality: true
    validates :introduction, presence: true, length: {maximum: 140, minimum: 10}
    validates :name, presence: true, uniqueness: true
 
end
