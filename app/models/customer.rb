class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :shipping_addresses, dependent: :destroy       
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true
  validates :email, uniqueness: true

  def name
    first_name + last_name
  end

  def addresses
    postal_code
  end
  
  enum status: {
   normal: 0,
   withdrawn: 1,
   banned: 2
 }
 has_many :cart_items, dependent: :destroy
end
