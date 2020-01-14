# frozen_string_literal: true

ActiveAdmin.register Article do
  permit_params :user_id, :title, :description, :accepted
end
