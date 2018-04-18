class UsersController < ApplicationController
  #before_action :authenticate_user!, except: [:index]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    render layout: "user_layout"
  end

  def edit
    p params
    @user=User.find_by(id:params[:id])
  end

  def update
    @user=User.find_by(id:params[:id])
    puts "and user"
    p current_user
    p @user
    if @user == current_user
    @user.update_attributes(user_params)
    puts "updated"

    else 
    redirect_to ('/')
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :bio, :avatar)
    end

end
