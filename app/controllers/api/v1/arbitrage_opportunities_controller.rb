module Api
    module V1
      class ArbitrageOpportunitiesController < ApplicationController
        def index
          @opportunities = ArbitrageOpportunity.order(created_at: :desc)
          render json: @opportunities
        end
      end
    end
  end