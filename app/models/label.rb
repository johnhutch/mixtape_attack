class Label < ActiveRecord::Base
  validates_presence_of :name
  has_many :albums
end
