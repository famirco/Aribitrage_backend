class PriceRecord < ApplicationRecord
  belongs_to :token
  validates :price_usdc, presence: true
  validates :gas_fee, presence: true
  validates :rpc_url, presence: true
end
