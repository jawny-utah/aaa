# frozen_string_literal: true

require 'spec_helper'

module FailureSignIn
  def dont_sign_in_fb
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  end

  def dont_sign_in_google
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
  end
end
