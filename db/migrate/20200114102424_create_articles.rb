# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
