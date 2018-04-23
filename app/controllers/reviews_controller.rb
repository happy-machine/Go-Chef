class ReviewsController < ApplicationController
  #before_action :authenticate_user!, except: [:index]


  def index
    @reviews = Review.all
  end

  def show
    @user = User.find(params[:id])
    userid = @user.id
    @reviews = Review.where("user_id = #{userid}")
     @review = Review.new(:user_id => @user.id)
    # binding.pry
  end


  def new
    @review = Review.new(:user_id => @user.id)
  end

  def create
    @user = User.find(params[:user_id])
    @review = @user.reviews.new(review_params)
    if @review.save
      flash[:notice] = "Review posted successfully."
      redirect_to(user_path(@user))
    else
      flash[:notice] = "Error"
      render('users#show')
    end
  end


  private


    def review_params
      params.require(:review).permit(:comment, :rating )
    end

end

