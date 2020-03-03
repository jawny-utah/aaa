# frozen_string_literal: true

class SettingsController < ApplicationController
  def new
    @setting = Setting.new(header_color: '#57B16D', background_color: '#1D8437', information_color: '#d9fded')
  end

  def create
    @setting = current_user.build_setting(settings_params)

    if @setting.save
      redirect_to home_path
    else
      render 'new'
    end
  end

  def edit
    @setting = current_user.setting
  end

  def update
    @setting = current_user.setting

    if @setting.update(settings_params)
      redirect_to home_path
    else
      render 'edit'
    end
  end

  private
  def settings_params
    params.require(:setting).permit(:header_color, :background_color, :information_color)
  end
end
