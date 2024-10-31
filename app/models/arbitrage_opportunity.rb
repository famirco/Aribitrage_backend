class ArbitrageOpportunity < ApplicationRecord
  belongs_to :token
  
  validates :buy_price, :sell_price, :profit, :profit_usd, :buy_rpc, :sell_rpc, :gas_fee, :status, presence: true
  
  scope :profitable, -> { where('profit_usd >= ?', 5.0) }
  scope :recent, -> { order(created_at: :desc) }
end