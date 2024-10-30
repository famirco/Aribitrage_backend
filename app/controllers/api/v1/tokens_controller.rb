module Api
  module V1
    class TokensController < BaseApiController
      def index
        @tokens = Token.all
        render json: @tokens
      end
    end
  end
end