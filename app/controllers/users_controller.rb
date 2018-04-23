class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order("created_at DESC")
    end
  end

  def show
    @user = User.find(params[:id])
    @review = Review.new
  end

  def edit
    p params
    @user = User.find(params[:id])
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
      @user.avatar = params[:file] if params[:file]
      @user.save!
      #binding.pry
      puts "saved"
    else 
      redirect_to ('/')
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :bio, :avatar, :user_id, )
    end

    def review_params
      params.require(:review).permit(:comment, :rating )
    end

end
