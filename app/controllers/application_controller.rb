class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :set_cors_headers
    
    private
    
    def set_cors_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, PATCH, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = '*'
      headers['Access-Control-Max-Age'] = '1728000'
      headers['Access-Control-Allow-Credentials'] = 'true'
    end
  
    def handle_options_request
      head :ok if request.request_method == 'OPTIONS'
    end
  end