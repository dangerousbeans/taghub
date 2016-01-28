class AddDescriptionAndIconToTags < ActiveRecord::Migration
  def change
    add_column :tags, :description, :text
    add_column :tags, :icon, :string
  end
end
