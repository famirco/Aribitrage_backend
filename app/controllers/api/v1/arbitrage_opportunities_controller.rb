module Api
  module V1
    class ArbitrageOpportunitiesController < ApplicationController
      def index
        opportunities = ArbitrageOpportunity
          .includes(:token)
          .order(profit_usd: :desc)
          .limit(100)
        render json: opportunities
      end
    end
  end
end