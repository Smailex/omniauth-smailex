require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Smailex < OmniAuth::Strategies::OAuth2
      option :name, :smailex

      option :client_options, {
        :site          => "https://smailex.com",
        :authorize_url => "/oauth/authorize",
        :token_url     => "/oauth/token"
      }

      uid { raw_info["id"] }

      info do
        name = raw_info["default_from"]["name"] if raw_info["default_from"]

        {
          :name  => name || raw_info["email"],
          :email => raw_info["email"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/users/me').parsed["user"]
      end
    end
  end
end
