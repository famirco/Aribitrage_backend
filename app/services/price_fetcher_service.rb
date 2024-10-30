class PriceFetcherService
  def initialize
    @rpc_urls = [
      ENV['RPC_URL_1'],
      ENV['RPC_URL_2'],
      ENV['RPC_URL_3'],
      ENV['RPC_URL_4']
    ]
  end

  def fetch_prices
    Rails.logger.info "Starting to fetch prices..."
    
    # برای تست، یک رکورد ساده ایجاد می‌کنیم
    token = Token.first_or_create!(
      name: "Fantom",
      symbol: "FTM",
      contract_address: "0x4e15361fd6b4bb609fa63c81a2be19d873717870"
    )

    @rpc_urls.each do |rpc_url|
      next if rpc_url.blank?
      
      PriceRecord.create!(
        token: token,
        price_usdc: rand(1.0..3.0),  # برای تست
        gas_fee: rand(0.1..0.5),     # برای تست
        rpc_url: rpc_url
      )
      
      Rails.logger.info "Created price record for #{token.symbol} from #{rpc_url}"
    end
  rescue => e
    Rails.logger.error "Error in fetch_prices: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
  end
end