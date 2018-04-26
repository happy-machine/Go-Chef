class ReviewsController < ApplicationController
  #before_action :authenticate_user!, except: [:index]


  def index
    @reviews = Review.all
  end

  def show
    @user = User.find(params[:id])
    @user_type = guest_user ? :guest : :registered
    @reviews = Review.where("user_id = #{@user.id}")
    @review = Review.new(:user_id => @user.id)
    # binding.pry
  end


  def new
    @review = Review.new(:user_id => @user.id)
  end

  def create
    p params
    @user = User.find(params[:user_id])
    @review = @user.reviews.new(review_params)
    @review.reviewer_name = current_user.name
    if @review.save
      redirect_to(user_path(@user))
    else
      flash[:error]="**Error saving review**"
      render('users#show')
    end
  end


  private


    def review_params
      params.require(:review).permit(:comment, :rating )
    end

end

