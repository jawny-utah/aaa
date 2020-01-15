# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin) { create(:user, role: :admin) }
  let(:user) { create(:user) }

  before do
    create(:user)
    create(:user, role: :admin)
  end

  describe 'GET #index' do
    it 'admin user' do
      admin.confirm
      sign_in admin
      get :index, params: {}
      expect(@controller.instance_variable_get(:@users).count).to eq(3)
    end

    it 'guest user' do
      user.confirm
      sign_in user
      get :index, params: {}
      expect(@controller.instance_variable_get(:@users).count).to eq(2)
    end

    it 'unsigned user' do
      get :index, params: {}
      expect(@controller.instance_variable_get(:@users).count).to eq(1)
    end
  end
end
