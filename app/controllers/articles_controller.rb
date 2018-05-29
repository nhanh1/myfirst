class ArticlesController < ApplicationController
	layout "articles"
	def index
		@articles = Article.order('created_at DESC').all
	end

	def show
		@article = find_commentable
    	@comments = @article.comments.arrange(:order => :created_at)
    	@comment = Comment.new
		#@comments = Comment.where(:article_id => params[:id])
	end

	def new
		@craft_article = CraftArticle.new(user_id: current_user.id)
		@craft_article.save
		redirect_to step_article_path(id: @article.id, step: 1)
	end

	def step
		@step = params[:step]
		if @step.to_i > 3
			@step = 3
		elsif @step.to_i < 1
			@step = 1
		end
		@craft_article = CraftArticle.find(params[:id])
	end
	
	def create
		debugger
		@id = params[:craft_article][:id]
		@craft_article = CraftArticle.find(@id)
		
		if params[:save]
			@step = params[:step]

			if @craft_article.update(article_params_edit)
				redirect_to step_article_path(@id, @step)
			else
				render 'edit'
			end
		elsif params[:next]
			@step = params[:step].to_i + 1

			if @craft_article.update(article_params_edit)
				redirect_to step_article_path(@id, @step)
			else
				@step = params[:step]
				render 'edit'
			end
		elsif params[:back]	
			@step = params[:step].to_i - 1

			if @craft_article.update(article_params_edit)
				redirect_to step_article_path(@id, @step)
			else
				@step = params[:step]
				render 'edit'
			end
		elsif params[:publish]
			if @craft_article.update(article_params_edit)
				@article = Article.new(@craft_article.slice(:title, :opening, :photo, :body, :conclusion, :about_author, :user_id))

				if @article.save
					@craft_article.destroy
					redirect_to @article
				else
					@step = params[:step]
					flash[:errors_publish_article] = @article.errors.full_messages
					render 'edit'
				end
			else
				render 'edit'
			end	
		end		
	end

	def edit
		@article = Article.find(params[:id])
		if current_user.id != @article.user_id
			redirect_to @article
		end
	end

	def update
		@article = Article.find(params[:id])

		if @article.update(article_params_edit)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy
	    @article = Article.find(params[:id])
	    @article.destroy
	 
	    redirect_to articles_path
	  end

	private
	def article_params_new
    	params.require(:craft_article).permit(:title, :opening, :photo, :body, :conclusion, :about_author, :user_id)
  	end

  	def article_params_edit
    	params.require(:article).permit(:title, :opening, :photo, :body, :conclusion, :about_author)
  	end
  	def find_commentable
		return params[:controller].singularize.classify.constantize.find(params[:id])
	end
end
