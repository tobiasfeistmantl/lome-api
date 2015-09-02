class CreateUserPositions < ActiveRecord::Migration
  def change
    create_table :user_positions do |t|
      t.references :user_session, index: true, foreign_key: true
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
    add_index :user_positions, :latitude
    add_index :user_positions, :longitude
  end
end
