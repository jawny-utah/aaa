# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'validate note description' do
    it { is_expected.to validate_presence_of :description }
  end

  describe 'validate note for user id' do
    it { is_expected.to validate_presence_of :user_id }
  end
end
