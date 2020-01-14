

require 'rails_helper'

RSpec.describe Article, type: :model do
  # let(:user) { create(:article, title: 'test title', description: 'description test', user_id: 1) }
  #
  # before do
  #   create(:article, title: 'test title1', user_id: 1)
  # end

  describe 'validate article title' do
    it { is_expected.to validate_presence_of :title }
  end

  describe 'validate article uniqueness' do
    it { is_expected.to validate_uniqueness_of(:title).scoped_to(:user_id).case_insensitive }
  end
end
