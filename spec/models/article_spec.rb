# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'validate article title' do
    it { is_expected.to validate_presence_of :title }
  end

  describe 'validate article uniqueness' do
    it { is_expected.to validate_uniqueness_of(:title).scoped_to(:user_id).case_insensitive }
  end
end
