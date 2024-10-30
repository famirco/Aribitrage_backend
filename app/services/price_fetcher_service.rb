class PriceFetcherService
  RPC_URLS = [
    'YOUR_RPC_URL_1',
    'YOUR_RPC_URL_2',
    'YOUR_RPC_URL_3',
    'YOUR_RPC_URL_4'
  ]

  def initialize(token)
    @token = token
  end

  def fetch_prices
    RPC_URLS.map do |rpc_url|
      fetch_price_from_rpc(rpc_url)
    end
  end

  private

  def fetch_price_from_rpc(rpc_url)
    provider = Web3::Eth::Rpc.new(rpc_url)
    # اینجا کد مربوط به دریافت قیمت از اسمارت کانترکت را قرار دهید
    # این یک مثال ساده است و نیاز به پیاده‌سازی کامل دارد
    price = get_token_price(provider)
    gas_fee = get_gas_fee(provider)

    PriceRecord.create!(
      token: @token,
      price_usdc: price,
      gas_fee: gas_fee,
      rpc_url: rpc_url
    )
  end

  def get_token_price(provider)
    # پیاده‌سازی دریافت قیمت از اسمارت کانترکت
  end

  def get_gas_fee(provider)
    # پیاده‌سازی دریافت gas fee
  end
end
