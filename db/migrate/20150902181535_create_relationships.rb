class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.references :follower, index: true
      t.references :followed, index: true

      t.timestamps null: false
    end
    add_foreign_key :relationships, :users, column: :follower_id
    add_foreign_key :relationships, :users, column: :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
