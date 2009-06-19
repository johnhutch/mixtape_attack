class AddQuickiesToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :fans_of, :string
    add_column :reviews, :tweet, :string
  end

  def self.down
    remove_column :reviews, :tweet
    remove_column :reviews, :fans_of
  end
end
