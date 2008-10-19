class ContentsController < ApplicationController
  def about
  end
  
  def help
  end
  
  def terms
  end
  
  def contact
  end
  
  def front
    @albums = Album.find(:all, 
                          :conditions => ['release_date > ?', Date.today], 
                          :order => "release_date ASC",
                          :limit => 15)
    @reviews = Review.find(:all, :order => "created_at DESC", :limit => 5)
    
    respond_to do |format|
      format.html # front.html.erb
      format.xml  { render :xml => @reviews }
    end
  end
end
