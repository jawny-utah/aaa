# frozen_string_literal: true

ActiveAdmin.register Note do
  permit_params :user_id, :description
end
