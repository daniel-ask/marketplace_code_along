class Listing < ApplicationRecord
  belongs_to :user
  has_one :purchase, dependent: :destroy
  has_many_attached :images
  validates :name, :price, :status, presence: true
  enum status: { active: 1, inactive: 2, purchased: 3 }
  scope :active, -> { where(status: 1) }
  after_initialize :set_default_status

  def set_default_status
    self.status ||= 1
  end
end
