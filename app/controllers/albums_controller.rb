class AlbumsController < ApplicationController
  protect_from_forgery :except => [:auto_complete_for_label_name, :auto_complete_for_artist_name]
  
  require_role "editor", :only => [:edit, :new, :create, :update, :destroy, :create_review, :review, :select]
  auto_complete_for :label, :name
  
  auto_complete_for :artist, :name
  
  # GET /albums
  # GET /albums.xml
  def index
    @albums = Album.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end
  
  def calendar
      @albums = Album.find(:all, 
                            :conditions => ['release_date > ?', Date.today], 
                            :order => "release_date ASC")
      @albums = @albums.paginate :per_page => 25, :page => params[:page]
      
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @albums }
      end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  def review
    @album = Album.find(params[:id])
    @rating = Rating.new
    #in the view, display rating select and, if current_user.has_role?('editor') display review form
    # give user option to do one, both, or neither
    # form submits to create_review_album_path
  end
  
  def create_review
    #lookg up album from params
    #create rating from params and assign to album
    #create review from params and assign to album
    #redirect to album show with review highlighted?
  end
  
  def genre
    @albums = Album.find_tagged_with(params[:id])
    @albums = @albums.paginate :per_page => 20, :page => params[:page]
    
    respond_to do |format|
      format.html # genre.html.erb
      format.xml  { render :xml => @albums }
    end
  end
  
  def select
    @albums = Album.find_all_by_artist_id(params[:id])
    @artist = Artist.find(params[:id])
    @album = Album.new
    
    respond_to do |format|
      format.html # select.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.create(params[:album])
    @album.label = Label.find_or_create_by_name(params[:label][:name].titleize)

    respond_to do |format|
      if @album.save
        # flash[:notice] = 'Album was successfully created.'
        format.html { redirect_to review_album_path(@album) }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        # flash[:notice] = 'Album was successfully updated.'
        format.html { redirect_to(@album) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to(albums_url) }
      format.xml  { head :ok }
    end
  end
end
