class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.text :body
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
