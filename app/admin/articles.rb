# frozen_string_literal: true

ActiveAdmin.register Article do
  permit_params :title, :description, :accepted

  index do
    column :title
    column :description
    column :accepted
  end
end
