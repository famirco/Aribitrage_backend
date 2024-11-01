module Api
  module V1
    class ConfigController < ApplicationController
      def index
        begin
          config = {
            tokens: Setting.tokens || [],
            networks: Setting.networks || [],
            status: 'success'
          }
          render json: config
        rescue => e
          Rails.logger.error "Error in config#index: #{e.message}"
          render json: { error: e.message }, status: :internal_server_error
        end
      end
    end
  end
end