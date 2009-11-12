class ContentsController < ApplicationController
  def about
  end
  
  def help
  end
  
  def terms
  end
  
  def contact
  end
  
  def admin
  end
  
  def front
    @coming_soon = Album.find(:all, 
                          :conditions => ['release_date > ?', Date.today], 
                          :order => "release_date ASC",
                          :limit => 15)
    @recent_reviews = Review.find(:all, :order => "created_at DESC", :limit => 3)
    
    respond_to do |format|
      #format.html { render :layout => "front" }
      format.html { }
      format.xml  { render :xml => @reviews }
    end
  end
end
