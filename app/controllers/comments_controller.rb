class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
  end

  def create
    @comment = current_user.comments.create content: comment_params[:content], micropost_id: comment_params[:micropost_id]
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to request.referrer || root_url
    else
      render 'microposts/show'
    end
  end

  def destroy
    @micropost =Micropost.find_by(id: params[:id])
    @comment = @micropost.comments.find_by(id: params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :micropost_id, :user_id)
    end

    def correct_user
      @mcomment = current_user.comments.find_by(id: params[:id])
      redirect_to request.referrer || root_url if @comment.nil?
    end
end
