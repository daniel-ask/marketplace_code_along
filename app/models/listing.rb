class Listing < ApplicationRecord
  belongs_to :user
  validates :name, :price, :status, presence: true
  scope :active, -> { where(status: 1) }
end
