class ArtistsLabels < ActiveRecord::Migration
  def self.up
    create_table :artists_labels do |t|
      t.integer :artist_id
      t.integer :label_id
    end
  end

  def self.down
    drop_table :artists_labels
  end
end
