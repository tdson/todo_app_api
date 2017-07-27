class Api::V1::GenerateToken
  class << self
    def perform user
      access_token = Doorkeeper::AccessToken.create resource_owner_id: user.id,
        expires_in: Doorkeeper.configuration.access_token_expires_in, use_refresh_token: false
      Doorkeeper::OAuth::TokenResponse.new(access_token).body
    end
  end
end
