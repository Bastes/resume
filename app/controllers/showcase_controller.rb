class ShowcaseController < ApplicationController
  caches_page :show

  before_filter :authorize, :except => :show

  # the showcase show view (trumps the admin controls when showing)
  def admin?
    @show ? false : super
  end

  # GET /
  # GET /showcase/
  def show
    @show  = true
    @items = Item.with_children.ordered.heads

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @items }
    end
  end

  # DELETE /showcase/
  def destroy
    expire_page('/')
    expire_page(:action => :show)
    flash[:notice] = "Cache expired."

    respond_to do |format|
      format.html { render root_path }
      format.xml  { head :ok }
      format.js   { render :text => flash[:notice] }
    end
  end
end
