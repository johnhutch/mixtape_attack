class NewsItemsController < ApplicationController
  # GET /news_items
  # GET /news_items.xml
  before_filter :login_required, :only => [:edit, :new, :create, :update, :destroy]
  require_role "editor", :only => [:admin, :destroy]
  
  def index
    @news_items = NewsItem.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news_items }
    end
  end
  
  def admin
    @news_items = NewsItem.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news_items }
    end
  end

  # GET /news_items/1
  # GET /news_items/1.xml
  def show
    @news_item = NewsItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @news_item }
    end
  end

  # GET /news_items/new
  # GET /news_items/new.xml
  def new
    @news_item = NewsItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @news_item }
    end
  end

  # GET /news_items/1/edit
  def edit
    @news_item = NewsItem.find(params[:id])
  end

  # POST /news_items
  # POST /news_items.xml
  def create
    @news_item = current_user.news_items.build(params[:news_item])

    respond_to do |format|
      if @news_item.save
        flash[:notice] = 'NewsItem was successfully created.'
        format.html { redirect_to(@news_item) }
        format.xml  { render :xml => @news_item, :status => :created, :location => @news_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /news_items/1
  # PUT /news_items/1.xml
  def update
    @news_item = NewsItem.find(params[:id])

    respond_to do |format|
      if @news_item.update_attributes(params[:news_item])
        flash[:notice] = 'NewsItem was successfully updated.'
        format.html { redirect_to(@news_item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @news_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /news_items/1
  # DELETE /news_items/1.xml
  def destroy
    @news_item = NewsItem.find(params[:id])
    @news_item.destroy

    respond_to do |format|
      format.html { redirect_to(news_items_url) }
      format.xml  { head :ok }
    end
  end
end
