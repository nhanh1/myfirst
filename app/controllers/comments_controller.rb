class CommentsController < ApplicationController
	def new
		@parent_id = params.delete(:parent_id)
		@commentable = find_commentable
		@comment = Comment.new(	:parent_id => @parent_id,
							   	:commentable_id => @commentable.id,
							   	:commentable_type => @commentable.class.to_s)
	end

	def create
		@commentable = find_commentable
		@comment = @commentable.comments.build(comment_params)
		@comment.user_id = current_user.id
		@comment.user_name = current_user.user_name
		if @comment.save
			flash[:notice] = "Successfully create comment."
			redirect_to article_path(params[:article_id])
		else
			flash[:errors_create_comment] = @comment.errors.full_messages
			redirect_to article_path(params[:article_id])
		end
	end

	def update
		@comment = Comment.find(params[:id])

		if @comment.update(comment_params_edit)
			redirect_to article_path(params[:article_id])
		else
			flash[:comment_id] = @comment.id
			flash[:errors_edit_comment] = @comment.errors.full_messages
			redirect_to article_path(params[:article_id])
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
	    @comment.destroy
	 
	    redirect_to article_path(params[:article_id])
	end

	private
	def comment_params
		params.require(:comment).permit(:body, :user_id, :parent_id)
	end

	def comment_params_edit
		params.require(:comment).permit(:body)
	end

	def find_commentable
		params.each do |name, value|
			if name =~ /(.+)_id$/
				return $1.classify.constantize.find(value)
			end
		end
	end
end