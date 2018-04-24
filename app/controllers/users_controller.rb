class UsersController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show] 

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
    userid = @user.id
    @reviews = Review.where("user_id = #{userid}").order("created_at ASC")
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
    @user = User.find(params[:id])
    if @user == current_user || session[:test_mode]==true
      @user.update_attributes(user_params)
      params[:file]?@user.avatar = params[:file]:nil
      if params[:search]
        pc = Geokit::Geocoders::MultiGeocoder.geocode (params[:search])
        p pc.lat
        @user.update_attributes(location_lat:pc.lat,location_lon:pc.lng)
      end
      @user.save!
      flash[:notice]="**User updated**"
      redirect_to :action => "show", :id => params[:id].to_i
    else 
      redirect_to ('/')
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :bio, :avatar, :user_id, :range_to, :location_lat, :location_lon, :search, :is_chef?)
    end
    def review_params
      params.require(:review).permit(:comment, :rating )
    end

end
