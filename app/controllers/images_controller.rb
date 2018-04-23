class ImagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @image = Image.new
  end


  def create
    @user = User.find(params[:user_id])
    #binding.pry
    if @user == current_user
      #assigning the image to the signed in user
      @image = @user.images.new(image_params)
      #saving the image and if it saves redirect to user profile, else re-render the form+errors 
      if @image.save
        redirect_to user_path(current_user)
        puts "saved"
      else
        puts "not saved"
        render :new
      end
    end
  end

  private

  def image_params
    params.require(:image).permit(:image)
  end
end


#logic for allowing multiple files to be uploaded at once, i will implement this as a feature at a later date
#params.require(:image).permit({images: []})