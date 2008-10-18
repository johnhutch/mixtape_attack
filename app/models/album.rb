class Album < ActiveRecord::Base
  acts_as_taggable
  
  belongs_to :artist
  belongs_to :label
  has_many :ratings
  has_many :reviews
  
  def release_date_string
    release_date.to_s
  end
  
  def release_date_string=(release_date_str)
    self.release_date = Time.parse(release_date_str)
  rescue ArgumentError
    @release_date_invalid = true
  end
  
  def score
    score = 0
    self.ratings.each do |rating|
      score += rating.score
    end
    score = score / self.ratings.length
  end
  
  def validate
    errors.add(:release_date, "is invalid.") if @release_date_invalid
  end
end
