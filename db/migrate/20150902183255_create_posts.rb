class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :message
      t.float :latitude
      t.float :longitude
      t.references :author, index: true
      t.string :image

      t.timestamps null: false
    end
    add_foreign_key :posts, :users, column: :author_id
    add_index :posts, :latitude
    add_index :posts, :longitude
  end
end
