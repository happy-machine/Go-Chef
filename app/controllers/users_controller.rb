class UsersController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show] 

  def index
    if current_user.name=="guest" && session[:user_type]!='guest' && session[:user_type]!='registered'
      @current_user=guest_user
      session[:user_type]="guest"
      render 'welcome'
    elsif session[:user_type]!='registered'
      @current_user=current_user
    else
      @current_user=current_user
      session[:user_type]="registered"
    end
    @users = User.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order("created_at DESC")
    end
  end

=begin
  def show_by_location
    @user= User.by_distance(:origin => current_user.postcode)
  end

  def show_by_rating
    @users User.average_rating.order("created_at ASC")
  end
=end

  def temp_user_created
    session[:user_postcode]=params[:user][:postcode]
    @users = User.all
    render 'index'
  end

  def show
    @user = User.find(params[:id]) || guest_user
    if user_signed_in?
      user_status = :signed_in 
    else
      user_status = :guest
    end
    @reviews = Review.where("user_id = #{@user.id}").order("created_at ASC")
    @review = Review.new
  end

  def edit
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
      params.require(:user).permit(:email, :bio, :avatar, :user_id, :range_to, :location_lat, :location_lon, :search, :is_a_chef, :max_party_size, :price_per_head, :postcode, :format)
    end
    def review_params
      params.require(:review).permit(:comment, :rating )
    end

end
