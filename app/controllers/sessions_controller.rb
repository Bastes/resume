class SessionsController < ApplicationController
  # GET /sessions/new
  # GET /sessions/new.xml
  def new
  end

  # POST /sessions
  # POST /sessions.xml
  def create
    session[:password] = params[:password]
    flash[:notice] = "Session created."
    redirect_to items_url
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.xml
  def destroy
    reset_session
    flash[:notice] = "Session destroyed."
    redirect_to items_url
  end
end
