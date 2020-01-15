# frozen_string_literal: true

class AddNicknameForUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nickname, :string
  end
end
