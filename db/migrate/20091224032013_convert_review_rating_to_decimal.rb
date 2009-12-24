class ConvertReviewRatingToDecimal < ActiveRecord::Migration
  def self.up
    change_column :reviews, :rating, :decimal, :precision => 2, :scale => 1
  end

  def self.down
    change_column :reviews, :rating, :integer
  end
end
