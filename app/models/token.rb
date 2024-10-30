class Token < ApplicationRecord
  has_many :price_records
  has_many :arbitrage_opportunities

  validates :name, presence: true
  validates :symbol, presence: true
  validates :contract_address, presence: true, uniqueness: true
end
