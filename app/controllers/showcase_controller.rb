class ShowcaseController < ApplicationController
  caches_page :show

  before_filter :authorize, :except => :show

  # the showcase is definetly not for the admin (trumps the admin controls)
  def admin?
    false
  end

  # GET /
  # GET /showcase/
  def show
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

    respond_to do |format|
      format.html render root_path
      format.xml { head :ok }
    end
  end
end
