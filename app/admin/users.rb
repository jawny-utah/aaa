# frozen_string_literal: true

ActiveAdmin.register User do
  permit_params :email, :nickname, :role, :birthday, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :provider
    column :nickname
    column :created_at
    column :birthday, &:birthday
    column :role do |user|
      user.role.presence
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :nickname
      row :email
      row :provider
      row :birthday, &:birthday
      row :role do |user|
        user.role.presence
      end
    end
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :nickname
      f.input :birthday
      f.input :role
    end
    f.actions
  end
end
