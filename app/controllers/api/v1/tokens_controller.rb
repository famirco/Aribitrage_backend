module Api
  module V1
    class TokensController < ApplicationController
      def index
        @tokens = Token.all
        render json: @tokens
      end
    end
  end
end