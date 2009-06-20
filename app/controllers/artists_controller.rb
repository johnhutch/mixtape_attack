class ArtistsController < ApplicationController
  protect_from_forgery :except => [:auto_complete_for_artist_name]
  auto_complete_for :artist, :name
  require_role "editor", :only => [:edit, :new, :create, :update, :destroy, :prelookup]
  
  # GET /artists
  # GET /artists.xml
  def index
    @artists = Artist.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @artists }
    end
  end

  # GET /artists/1
  # GET /artists/1.xml
  def show
    @artist = Artist.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @artist }
    end
  end

  # GET /artists/prelookup
  # GET /artists/prelookup.xml
  def prelookup
    @artist = Artist.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @artist }
    end
  end

  # GET /artists/1/edit
  def edit
    @artist = Artist.find(params[:id])
  end
  
  def new
    @artist = Artist.find_by_name(params[:artist][:name].titleize)
    
    if @artist.nil?
      # artist does not exist and we ask them to add it
      @artist_name = params[:artist][:name].titleize
      respond_to do |format|
          format.html # prelookup.html.erb
      end
    else
      respond_to do |format|
        # artist exists and we ask them to choose or add an album
        format.html { redirect_to select_album_path(@artist) }
        format.xml  { render :xml => @artist, :status => :created, :location => @artist }
      end
    end
  end

  # POST /artists
  # POST /artists.xml
  def create
    @artist = Artist.create(params[:artist])

    respond_to do |format|
      if @artist.save
        flash[:notice] = 'Artist was successfully created.'
        format.html { redirect_to select_album_path(@artist) }
        format.xml  { render :xml => @artist, :status => :created, :location => @artist }
      else
        flash[:notice] = 'Hrm, something went wrong...'
        format.html { render :action => "new" }
        format.xml  { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /artists/1
  # PUT /artists/1.xml
  def update
    @artist = Artist.find(params[:id])

    respond_to do |format|
      if @artist.update_attributes(params[:artist])
        # flash[:notice] = 'Artist was successfully updated.'
        format.html { redirect_to(@artist) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @artist.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.xml
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to(artists_url) }
      format.xml  { head :ok }
    end
  end
end
