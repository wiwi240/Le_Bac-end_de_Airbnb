class User < ApplicationRecord
  # Association obligatoire pour city_id
  belongs_to :city
  
  has_secure_password
  has_many :gossips
  has_many :comments
  has_many :likes

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end