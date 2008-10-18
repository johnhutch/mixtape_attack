class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.integer :album_id
      t.integer :rating_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end
