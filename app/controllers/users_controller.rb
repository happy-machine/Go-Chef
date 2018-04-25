class UsersController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show] 

  def index
    p params
    if !user_signed_in? && session[:temp_user]==nil
      temp_user = User.new(id:1000000)
      temp_user.save
      @current_user=temp_user
      render 'welcome'
    end
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order("created_at DESC")
    end
  end

  def show
    @user = User.find(params[:id]) || session[:temp_user]
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
      if params[:search].length>4
        pc = Geokit::Geocoders::MultiGeocoder.geocode (params[:search])
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
      params.require(:user).permit(:email, :bio, :avatar, :user_id, :range_to, :location_lat, :location_lon, :search, :is_a_chef, :max_party_size, :price_per_head)
    end
    def review_params
      params.require(:review).permit(:comment, :rating )
    end

end
