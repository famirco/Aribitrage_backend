class ArbitrageOpportunity < ApplicationRecord
  belongs_to :token

  validates :buy_price, presence: true
  validates :sell_price, presence: true
  validates :profit, presence: true
end
