module Api
  module V1
    class ConfigController < ApplicationController
      def index
        Rails.logger.info "Starting config#index action"
        
        tokens = Setting.tokens
        networks = Setting.networks
        
        Rails.logger.info "Tokens: #{tokens.inspect}"
        Rails.logger.info "Networks: #{networks.inspect}"
        
        config = {
          tokens: tokens,
          networks: networks
        }
        
        Rails.logger.info "Final config: #{config.inspect}"
        
        render json: config
      rescue => e
        Rails.logger.error "Error in config#index: #{e.message}"
        Rails.logger.error e.backtrace.join("\n")
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end