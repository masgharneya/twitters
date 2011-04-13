class UsersController < ApplicationController
	before_filter :authenticate, :only => [:index, :edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user, :only => [:destroy]
	
	def new
		@user = User.new
		@title = "Sign up"
	end
	
	def index
		@title = "All users"
		@users = User.paginate(:page => params[:page], :per_page => 5)
	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(:page => params[:page], :per_page => 15)
		@title = @user.name
	end
	
	def create
		@user = User.new(params[:user])
		if @user.save
			if params[:subscribe]
			
				h = Hominid::API.new('a67377fd69cd5c2e1a69e469c9930319-us2')
				h.list_subscribe('fb3633d1cd',@user.email, [], 'html', false, true, true, true)
			end
			sign_in @user
			flash[:success] = "Welcome to Twitter 2.0!"
			redirect_to @user
		else
			@title = "Sign up"
			@user.password = ''
			@user.password_confirmation = ""
			render 'new'
		end
	end
	
	def edit
		@user = User.find(params[:id])
		@title = "Edit user"
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			@title = "Edit user"
			render 'edit'
		end
	end
	
	def destroy
		User.find(params[:id]).destroy
		flash[:sucess] = "User destroyed."
		redirect_to users_path
	end
	
	private
		
		
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
		
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
