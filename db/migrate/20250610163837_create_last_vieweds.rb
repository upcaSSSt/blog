class CreateLastVieweds < ActiveRecord::Migration[7.1]
  def change
    create_table :last_vieweds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true
      t.references :message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
