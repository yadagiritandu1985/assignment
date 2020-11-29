class ApplicationController < ActionController::API
  before_action :authenticate_request, except: [:register, :login]
  attr_reader :current_user

  private
  
  def authenticate_request
    load_current_user
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
  
  def decoded_auth_token
    return nil unless http_auth_header
    
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].split(' ').last
    end
    nil
  end
  
  def load_current_user
    return nil unless decoded_auth_token

    @current_user ||= User.find_by(id: decoded_auth_token[:user_id])
  end
end
