class ImagesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def new
    @user = User.find(params[:user_id])
    @image = Image.new
  end

  def destroy
    p User.find(params[:user_id])
    User.find(params[:user_id]).images.delete(params[:id])
    flash[:notice]="**Image Deleted**"
    redirect_to new_user_image_path(current_user)
  end
  def create
    @user = User.find(params[:user_id])
    if @user == current_user && params[:image]
      @image = @user.images.new(image_params)
      if @image.save
        redirect_to new_user_image_path(params[:user_id])
        flash[:notice]="**Image Saved**"
      else
        flash[:notice]="**Image Not Saved**"
        render :new
      end
    else
      redirect_to user_path(params[:user_id])
    end
  end

  private

  def image_params
    params.require(:image).permit(:image,:id)
  end
end


#logic for allowing multiple files to be uploaded at once, i will implement this as a feature at a later date
#params.require(:image).permit({images: []})