# frozen_string_literal: true

require 'spec_helper'

module OmniAuthTestHelper
  def mock_auth_hash_fb(without_email=false)
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook',
      uid: '123545',
      info: {
        first_name: 'Gaius',
        last_name: 'Baltar',
        email: without_email ? nil : 'test@example.com'
      },
      credentials: {
        token: '123456',
        secret: 'mock secret'
      }
    )
  end

  def mock_auth_hash_google(without_email=false)
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123545',
      info: {
        first_name: 'Gaius',
        last_name: 'Baltar',
        email: without_email ? nil : 'test@example.com'
      },
      credentials: {
        token: '123456',
        secret: 'mock secret'
      }
    )
  end
end
