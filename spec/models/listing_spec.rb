require 'rails_helper'

RSpec.describe Listing, type: :model do
  let(:user) { User.new }
  subject(:listing) do
    described_class.new(
      name: 'Test Drone',
      description: 'Awesome Drone',
      weight: 150,
      max_speed: 19,
      battery_capacity: 3000,
      status: 1,
      price: 105.5,
      user: user
    )
  end

  it 'is valid with valid attributes' do
    expect(listing).to be_valid
  end

  context 'Database tables' do
    it { expect(listing).to have_db_column(:name).of_type(:string) }
    it { expect(listing).to have_db_column(:description).of_type(:text) }
    it { expect(listing).to have_db_column(:weight).of_type(:integer) }
    it { expect(listing).to have_db_column(:max_speed).of_type(:integer) }
    it { expect(listing).to have_db_column(:battery_capacity).of_type(:integer) }
    it { expect(listing).to have_db_column(:status).of_type(:integer) }
    it { expect(listing).to have_db_column(:price).of_type(:decimal) }
  end

  context 'validations' do
    it { expect(listing).to validate_presence_of(:name)}
    it { expect(listing).to validate_presence_of(:price)}
    it { expect(listing).to validate_presence_of(:status)}
  end

  context 'associations' do
    it { should belong_to(:user) }
  end
end
