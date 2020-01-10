require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    User.create(email: 'user1@example.com', password: 'password', role: :guest)
    User.create(email: 'admin1@example.com', password: 'password', role: :admin)
  end

describe "GET #index" do
  it 'admin user' do
    admin = User.create(email: 'admin2@example.com', password: 'password', role: :admin)
    admin.confirm
    sign_in admin
    get :index, params: {}
    expect(@controller.instance_variable_get(:@users).count).to eq(3)
  end
  it "guest user" do
    user = User.create(email: "user3@example.com", password: "password", role: :guest)
    user.confirm
    sign_in user
    get :index, params: {}
    expect(@controller.instance_variable_get(:@users).count).to eq(2)
  end
    it "unsigned user" do
      get :index, params: {}
      expect(@controller.instance_variable_get(:@users).count).to eq(1)
    end
  end
end
