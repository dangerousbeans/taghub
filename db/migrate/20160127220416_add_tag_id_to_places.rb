class AddTagIdToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :tag_id, :integer
  end
end
