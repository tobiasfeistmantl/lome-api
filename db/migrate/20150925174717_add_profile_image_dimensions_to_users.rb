class AddProfileImageDimensionsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_image_dimensions, :json
  end
end
