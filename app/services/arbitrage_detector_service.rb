class ArbitrageDetectorService
  MIN_PROFIT_USD = 5.0

  def detect_opportunities
    opportunities = []
    
    Token.find_each do |token|
      token_prices = PriceRecord.where(token: token).order(price_usdc: :asc)
      
      next if token_prices.count < 2

      token_prices.each do |buy_price|
        token_prices.each do |sell_price|
          next if buy_price == sell_price
          
          price_diff = sell_price.price_usdc.to_f - buy_price.price_usdc.to_f
          profit_percentage = (price_diff / buy_price.price_usdc.to_f) * 100
          profit_usd = price_diff.abs

          # Only consider opportunities with profit > $5
          if profit_usd >= MIN_PROFIT_USD
            opportunities << {
              token: token,
              buy_price: buy_price.price_usdc,
              sell_price: sell_price.price_usdc,
              profit: profit_percentage.to_s,
              profit_usd: profit_usd.to_s,
              buy_rpc: buy_price.rpc_url,
              sell_rpc: sell_price.rpc_url,
              gas_fee: buy_price.gas_fee,
              status: 'detected'
            }
          end
        end
      end
    end

    opportunities.sort_by { |opp| -opp[:profit_usd].to_f }
  end
end