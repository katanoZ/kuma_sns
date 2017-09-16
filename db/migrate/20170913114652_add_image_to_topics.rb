class AddImageToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :image, :string
    add_column :topics, :flickr_url, :string
  end
end
