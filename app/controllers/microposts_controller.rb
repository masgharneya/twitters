class MicropostsController < ApplicationController
	before_filter :authenticate
	
	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:sucess] = "Micropost created!"
			redirect_to root_path
		else
			@feed_items = []
			flash[:failure] = "That tweets wasn't the right length dude!"
			redirect_to root_path
		end
	end
	
	def destroy
	end
end