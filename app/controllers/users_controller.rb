class UsersController < ApplicationController
  #before_action :authenticate_user!, except: [:index]


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    p params
    @user=User.find_by(id:params[:id])
  end

  def test
    session[:test_mode]= !session[:test_mode]
    @testmode=session[:test_mode]
    render 'test'
  end
  def update
    @user=User.find_by(id:params[:id])
    if @user == current_user || session[:test_mode]==true
    @user.update_attributes(user_params)
    else 
    redirect_to ('/')
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :bio, :avatar)
    end

end
