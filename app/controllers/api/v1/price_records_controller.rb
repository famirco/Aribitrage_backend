module Api
  module V1
    class PriceRecordsController < ApplicationController
      def index
        @prices = PriceRecord.includes(:token).order(created_at: :desc)
        render json: @prices
      end

      def create
        @price = PriceRecord.new(price_record_params)
        if @price.save
          render json: @price, status: :created
        else
          render json: @price.errors, status: :unprocessable_entity
        end
      end

      private

      def price_record_params
        params.require(:price_record).permit(:token_id, :price_usdc, :gas_fee, :rpc_url)
      end
    end
  end
end
