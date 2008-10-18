class Album < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :artist
  belongs_to :label
  has_many :ratings
  has_many :reviews
end
