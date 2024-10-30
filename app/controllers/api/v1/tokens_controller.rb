module Api
  module V1
    class TokensController < ApplicationController
      def index
        @tokens = Token.all
        render json: @tokens
      end

      def show
        @token = Token.find(params[:id])
        render json: @token
      end
    end
  end
end
