require 'json_web_token.rb'

module Request
  module AuthHelpers
    def auth_headers(user)
      token = JsonWebToken.encode({ user_id: user.id })
      {
        'Authorization': "Bearer #{token}",
        'Accept': 'application/json', 
        'Content-Type': 'application/json'
      }
    end
  end
end
