class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.references :user, foreign_key: true
      t.string :header_color
      t.string :background_color
      t.string :information_color

      t.timestamps
    end
  end
end
