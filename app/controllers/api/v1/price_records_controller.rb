module Api
  module V1
    class PriceRecordsController < ApplicationController
      def index
        @price_records = PriceRecord.includes(:token).order(created_at: :desc).limit(100)
        render json: @price_records
      end
    end
  end
end