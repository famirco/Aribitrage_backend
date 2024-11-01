module Api
  module V1
    class TokensController < ApplicationController
      def index
        begin
          tokens = Setting.tokens || []
          render json: { tokens: tokens, status: 'success' }
        rescue => e
          Rails.logger.error "Error in tokens#index: #{e.message}"
          render json: { error: e.message }, status: :internal_server_error
        end
      end
    end
  end
end