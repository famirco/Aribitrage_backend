class PriceFetcherService
  def initialize
    # حذف map و web3 client ها برای فعلاً
    @rpc_urls = [
      ENV.fetch('RPC_URL_1', 'https://rpc.ftm.tools'),
      ENV.fetch('RPC_URL_2', 'https://rpcapi.fantom.network'),
      ENV.fetch('RPC_URL_3', 'https://fantom-mainnet.public.blastapi.io'),
      ENV.fetch('RPC_URL_4', 'https://rpc.ankr.com/fantom')
    ]
  end

  def fetch_prices
    Rails.logger.info "Starting to fetch prices..."
    
    # ایجاد یک توکن تست
    token = Token.first_or_create!(
      name: "Fantom",
      symbol: "FTM",
      contract_address: "0x4e15361fd6b4bb609fa63c81a2be19d873717870"
    )

    # ایجاد رکوردهای قیمت تست
    @rpc_urls.each do |rpc_url|
      PriceRecord.create!(
        token: token,
        price_usdc: rand(1.0..3.0).round(6),
        gas_fee: rand(0.1..0.5).round(6),
        rpc_url: rpc_url
      )
      Rails.logger.info "Created price record for #{token.symbol} from #{rpc_url}"
    end
  rescue => e
    Rails.logger.error "Error in fetch_prices: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
  end
end