odule Api
  module V1
    class ArbitrageOpportunitiesController < ApplicationController
      def index
        opportunities = ArbitrageOpportunity
          .includes(:token)
          .order(created_at: :desc)
          .limit(100)
        
        render json: opportunities, include: :token
      end
    end
  end
end