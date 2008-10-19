class Rating < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  validates_presence_of :score
end
