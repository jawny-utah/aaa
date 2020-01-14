# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references :user, foreign_key: true
      t.text :description
      t.timestamps
    end
  end
end
