class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :listings, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_one :profile
  validates :username, presence: true, uniqueness: true, format: { with: /\A\w+\z/, message: 'username has to only contain alphanumeric characters' }
end
