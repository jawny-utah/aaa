# frozen_string_literal: true

class GuestToDefaultRole < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :role, from: nil, to: 1
  end
end
