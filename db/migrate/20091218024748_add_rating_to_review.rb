class AddRatingToReview < ActiveRecord::Migration
  def self.up
    add_column :reviews, :rating, :integer  
    drop_table :ratings
  end

  def self.down
    remove_column :reviews, :rating 
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :album_id
      t.integer :score

      t.timestamps
    end
  end
end
