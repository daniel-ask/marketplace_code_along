class Listing < ApplicationRecord
  belongs_to :user
  validates :name, :price, :status, presence: true
end
