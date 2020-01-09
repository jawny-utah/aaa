ActiveAdmin.register User do
  permit_params :email, :role, :birthday, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :created_at
    column :birthday do |user|
      user.birthday
    end
    column :role do |user|
      user.role unless user.role.blank?
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :birthday do |user|
        user.birthday
      end
      row :role do |user|
        user.role unless user.role.blank?
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
      f.input :birthday
      f.input :role
    end
    f.actions
  end
end
