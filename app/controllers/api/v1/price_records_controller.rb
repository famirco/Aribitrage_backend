module Api
  module V1
    class PriceRecordsController < BaseApiController
      def index
        @price_records = PriceRecord.all
        render json: @price_records
      end
    end
  end
end