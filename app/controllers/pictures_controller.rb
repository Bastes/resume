class PicturesController < ApplicationController
  # GET /items/1/pictures
  # GET /items/1/pictures.xml
  def index
    @pictures = Picture.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.js   { render :layout => 'ajax' }
      format.xml  { render :xml => @pictures }
    end
  end

  # GET /items/1/pictures/1
  # GET /items/1/pictures/1.xml
  def show
    @picture = Picture.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js   { render :layout => 'ajax' }
      format.xml  { render :xml => @picture }
    end
  end

  # GET /items/1/pictures/new
  # GET /items/1/pictures/new.xml
  def new
    @picture = Picture.new

    respond_to do |format|
      format.html # new.html.erb
      format.js   { render :layout => 'ajax' }
      format.xml  { render :xml => @picture }
    end
  end

  # POST /items/1/pictures
  # POST /items/1/pictures.xml
  def create
    @picture = Picture.new(params[:picture])

    respond_to do |format|
      if @picture.save
        flash[:notice] = 'Picture was successfully created.'
        format.html { redirect_to(@picture) }
        format.js   { render :action => "show", :layout => 'ajax' }
        format.xml  { render :xml => @picture, :status => :created, :location => @picture }
      else
        format.html { render :action => "new" }
        format.js   { render :action => "new", :status => 403,
                             :layout => 'ajax' }
        format.xml  { render :xml => @picture.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1/pictures/1
  # DELETE /items/1/pictures/1.xml
  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    flash[:notice] = 'Picture was successfully deleted.'

    respond_to do |format|
      format.html { redirect_to(pictures_url) }
      format.js   { render :text => "", :layout => 'ajax' }
      format.xml  { head :ok }
    end
  end
end
