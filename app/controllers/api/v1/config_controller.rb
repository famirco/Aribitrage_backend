module Api
  module V1
    class ConfigController < ApplicationController
      def index
        begin
          render json: {
            tokens: Setting.tokens || [],
            networks: Setting.networks || [],
            status: 'success'
          }
        rescue => e
          Rails.logger.error "Error: #{e.message}"
          render json: { error: e.message }, status: :internal_server_error
        end
      end
    end
  end
end