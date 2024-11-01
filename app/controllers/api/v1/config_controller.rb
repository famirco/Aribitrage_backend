module Api
  module V1
    class ConfigController < ApplicationController
      def index
        config = {
          tokens: Setting.tokens,
          networks: Setting.networks
        }
        
        render json: config
      end
    end
  end
end