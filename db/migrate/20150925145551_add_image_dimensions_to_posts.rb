class AddImageDimensionsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :image_dimensions, :json
  end
end
