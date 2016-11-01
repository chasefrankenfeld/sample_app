class MicropostsController < ApplicationController
  #include ActionController::MimeResponds
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  #respond_to :html, :js

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  # This can be romved as Rails can generate this for me
  def edit
    #respond_to do |format|
    #  format.html
    #  format.json
    #end
  end

  def update
    if current_user?(@micropost.user)
      @micropost.update_attributes(micropost_params)
      redirect_to root_url
      flash[:success] = "Micropost updated"
    else
      render 'edit'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url  # request.referrer redirects back to the previous page. THe page issuing the delete request.
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
