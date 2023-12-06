class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_products, through: :bookmarks, source: :product
  has_many :wardrobes, dependent: :destroy
  has_many :wardrobe_products, through: :wardrobes, source: :product
  has_one_attached :avatar, dependent: :destroy
  has_many :scans, dependent: :destroy
  has_many :products, dependent: :destroy
end
