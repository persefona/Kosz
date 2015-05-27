class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index,:show]
	def index
		@posts = Post.all.order('created_at DESC')
	end

	def new
		@post = Post.new
		@categories = Category.all.map do |category| 
    		[category.title, category.id] 
	end
end

	def create
		
		@post = Post.new(post_params)
		@post.user_id = current_user.id

		if @post.save

		flash[:notice]="Post został dodany!"
        redirect_to posts_path
       
		else
			 render :action => 'new'
			
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update 
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :body))
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy

		redirect_to root_path
	end


	private
		def post_params

			params.require(:post).permit(:title, :body, :category_id, :user_id)

		end
				
	 end

	


 


