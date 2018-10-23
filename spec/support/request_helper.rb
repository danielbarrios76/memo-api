# frozen_string_literal: true

module Requests
  module JsonHelpers
    def json_response
      JSON.parse(response.body)
    end
  end

  module HeaderHelpers
    def user_headers(user)
      user.create_new_auth_token.slice('client', 'access-token', 'uid', 'expiry')
    end
  end
end
