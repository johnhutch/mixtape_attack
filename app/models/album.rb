class Album < ActiveRecord::Base
  acts_as_taggable
  
  has_attached_file :art,
              :path => ":rails_root/public/bin/:class/:attachment/:id/:style_:basename.:extension",
              :url => "/bin/:class/:attachment/:id/:style_:basename.:extension",
              :default_url => "/images/missing_:class_:style.png",
              :styles => { :thumb => "80x80#",
                           :frontlist => "150x150#",
                           :featured => "200x200#" }
                           
  validates_presence_of :artist_id, :name
                           
  belongs_to :artist
  belongs_to :label
  has_many :reviews
    
  def release_date_string
    release_date.strftime('%B %e, %Y') unless release_date.nil?
  end
  
  def release_date_string=(release_date_str)
    self.release_date = Time.parse(release_date_str)
  rescue ArgumentError
    @release_date_invalid = true
  end
  
  def artist_name
    Artist.find(self.artist_id).name
  end
  
  def label_name
    Label.find(self.label_id).name
  end
  
  def rating
    score = 0
    self.reviews.each do |review|
      score += review.rating
    end
    if score == 0
      score = 0
    else
      score = sprintf ("%.1f", score / self.reviews.length)
    end
  end
  
  def validate
    errors.add(:release_date, "is invalid.") if @release_date_invalid
  end
  

end
