class ItemsController < ApplicationController
  before_filter :get_parent
  before_filter :authorize

  def get_parent
    @parent = Item.find(params[:item_id]) if params[:item_id]
  end

  # GET /items
  # GET /items/1/children
  # GET /items.xml
  # GET /items/1/children.xml
  def index
    if @parent
      @items = @parent.children.with_children.ordered.find(:all)
    else
      @items = Item.with_children.ordered.heads
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js   { render :layout => 'ajax' }
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.with_children.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.js   { render :layout => 'ajax' }
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/1/children/new
  # GET /items/new.xml
  # GET /items/1/children/new.xml
  def new
    @item = Item.new(:parent => @parent)

    respond_to do |format|
      format.html # new.html.erb
      format.js   { render :layout => 'ajax' }
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # edit.html.erb
      format.js   { render :layout => 'ajax' }
      format.xml  { render :xml => @item }
    end
  end

  # POST /items
  # POST /items/1/children
  # POST /items.xml
  # POST /items/1/children.xml
  def create
    @item = Item.new(params[:item])
    @item.parent = @parent

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(@item) }
        format.js   { render :action => "show", :layout => 'ajax' }
        format.xml  { render :xml => @item, :status => :created,
                             :location => @item }
      else
        format.html { render :action => "new" }
        format.js   { render :action => "new", :status => 403,
                             :layout => 'ajax' }
        format.xml  { render :xml => @item.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.js   { render :action => "show", :layout => 'ajax' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.js   { render :action => "edit", :status => 403,
                             :layout => 'ajax' }
        format.xml  { render :xml => @item.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    flash[:notice] = 'Item was successfully deleted.'

    respond_to do |format|
      format.html { redirect_to(items_path) }
      format.js   { render :text => "", :layout => 'ajax' }
      format.xml  { head :ok }
    end
  end
end
