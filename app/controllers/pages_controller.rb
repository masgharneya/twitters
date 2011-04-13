class PagesController < ApplicationController
  def home
  	@title = "Home"
	if signed_in?
		@micropost = Micropost.new
		@feed_items = Micropost.all.paginate(:page => params[:page])
	end
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
  end
  
  def help
  	@title = "Help"
  end

end
