class ImagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @image = Image.new
  end


  def create
    @user = User.find_by(params[:id])
    if @user == current_user || session[:test_mode] == true
      #assigning the image to the signed in user
      @image = @user.images.new(image: params[:file])
      #saving the image and if it saves redirect to user profile, else re-render the form+errors
      if @image.save
        redirect_to user_path(current_user)
        puts "saved"
      else
        render :new
      end
      #binding.pry
    end
  end
end


#logic for allowing multiple files to be uploaded at once, i will implement this as a feature at a later date
#params.require(:image).permit({images: []})