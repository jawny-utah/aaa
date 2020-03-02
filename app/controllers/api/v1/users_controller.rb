# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  def index
  end

  def show
  end

  def update
    render json: { nickname: current_user.nickname }, status: :ok if current_user.update(user_params)
  end

  private
  def parsed_params
    @parsed_params ||= ActionController::Parameters.new(JSON.parse(request.body.read, symbolize_names: true))
  end

  def user_params
    parsed_params.require(:user).permit(:nickname)
  end
end
