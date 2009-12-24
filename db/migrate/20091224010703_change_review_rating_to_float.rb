class ChangeReviewRatingToFloat < ActiveRecord::Migration
  def self.up
    change_column :reviews, :rating, :decimal
  end

  def self.down
    change_column :reviews, :rating, :integer
  end
end
