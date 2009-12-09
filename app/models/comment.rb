class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, :polymorphic => true
  
  acts_as_textiled :body
  
  validates_presence_of :body
end
