class CommentsController < ApplicationController

  def create

    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    if @comment.save
      
      # @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end
