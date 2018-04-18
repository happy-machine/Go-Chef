class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    #binding.pry
  end

  def edit
    p params
    @user=User.find_by(id:params[:id])
  end

  def update
    @user=User.find_by(email:params[:user][:email])
    @user.update_attributes(user_params)
    redirect_to ('/')
  end

  private

    def user_params
      params.require(:user).permit(:email, :bio, :avatar)
    end

end
