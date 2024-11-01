module Api
  module V1
    class PriceRecordsController < ApplicationController
      def index
        begin
          records = PriceRecord.order(created_at: :desc).limit(100)
          render json: records
        rescue => e
          Rails.logger.error "Error in price_records#index: #{e.message}"
          render json: { error: e.message }, status: :internal_server_error
        end
      end
    end
  end
end