class ReviewsController < ApplicationController
  # GET /reviews
  # GET /reviews.xml
  require_role "editor", :only => [:edit, :new, :create, :update, :destroy]
  
  def index
    @reviews = Review.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reviews.to_xml(:include => [:album]) }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.xml
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.xml
  def create
    @review = current_user.reviews.build(params[:review])

    respond_to do |format|
      if @review.save
        add_tags(params[:tag_list], @review)
        
        flash[:notice] = 'Review was successfully created.'
        format.html { redirect_to(@review) }
        format.xml  { render :xml => @review, :status => :created, :location => @review }
      else
        @album = Album.find(params[:album])
        format.html { render :action => "../albums/review" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.xml
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        add_tags(params[:tag_list], @review)
        flash[:notice] = 'Review was successfully updated.'
        format.html { redirect_to(@review) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @review.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.xml
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to(reviews_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def add_tags(tags, review)
    @a = Album.new()
    @a.tag_list = tags
    review.album.tag_list.add(@a.tag_list)
    review.album.save
  end
end
