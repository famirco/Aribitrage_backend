class ArbitrageDetectorService
    def initialize(min_profit_percentage = 1.0)
      @min_profit_percentage = min_profit_percentage
    end
  
    def detect_opportunities
      Token.all.each do |token|
        prices = token.price_records.order(created_at: :desc).limit(4)
        next if prices.count < 2
  
        min_price = prices.min_by(&:price_usdc)
        max_price = prices.max_by(&:price_usdc)
        
        profit_percentage = ((max_price.price_usdc.to_f - min_price.price_usdc.to_f) / min_price.price_usdc.to_f * 100)
        
        if profit_percentage >= @min_profit_percentage
          ArbitrageOpportunity.create!(
            token: token,
            buy_price: min_price.price_usdc,
            sell_price: max_price.price_usdc,
            profit: profit_percentage,
            buy_rpc: min_price.rpc_url,
            sell_rpc: max_price.rpc_url,
            gas_fee: min_price.gas_fee.to_f + max_price.gas_fee.to_f,
            status: 'detected'
          )
        end
      end
    end
  end