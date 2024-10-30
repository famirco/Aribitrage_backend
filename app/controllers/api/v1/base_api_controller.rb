module Api
    module V1
      class BaseApiController < ApplicationController
        skip_before_action :verify_authenticity_token
        before_action :handle_options_request
      end
    end
  end