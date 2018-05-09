class CommentsController < ApplicationController
  def index
  end

  def create
    @comment = current_user.comments.create
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_back_or user
    else
      render 'microposts/show'
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :micropost_id, :user_id, :parent_id)
  end
end
