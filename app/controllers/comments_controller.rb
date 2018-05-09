class CommentsController < ApplicationController
  def index
  end

  def create
    @comment = current_user.comments.create content: comment_params[:content], micropost_id: comment_params[:micropost_id]
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_back_or micropost_path(@comment.micropost)
    else
      render 'microposts/show'
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :micropost_id, :user_id, :parent_id)
  end
end
