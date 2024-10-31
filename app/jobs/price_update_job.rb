class PriceUpdateJob < ApplicationJob
    queue_as :default
  
    def perform
      prices = PriceFetcherService.new.fetch_prices
      opportunities = ArbitrageDetectorService.new.detect_opportunities
      
      # Store only arbitrage opportunities
      opportunities.each do |opp|
        ArbitrageOpportunity.create!(
          token: opp[:token],
          buy_price: opp[:buy_price],
          sell_price: opp[:sell_price],
          profit: opp[:profit],
          profit_usd: opp[:profit_usd],
          buy_rpc: opp[:buy_rpc],
          sell_rpc: opp[:sell_rpc],
          gas_fee: opp[:gas_fee],
          status: opp[:status]
        )
      end
    end
  end