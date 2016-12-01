class MicropostsController < ApplicationController
  #include ActionController::MimeResponds
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  #respond_to :html, :js

  def create
    @micropost = current_user.microposts.build

    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # This can be romved as Rails can generate this for me
  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update_attributes(micropost_params)
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      render 'edit'
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    if @micropost.destroy
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

    private

      def micropost_params
        params.require(:micropost).permit(:content)
      end

      def correct_user
        @micropost = current_user.microposts.find_by(id: params[:id])
        redirect_to root_url if @micropost.nil?
      end

end
