class UsersController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show] 

  def index
    @current_user=current_user
      @users= User.all
  end

  def search
    @current_user=current_user
    begin
      if params.has_key?(:name)
        @users = User.search(session[:postcode]).order("created_at DESC")
      elsif params.has_key?(:location) && valid_postcode(session[:postcode])
        @users = User.by_distance(:origin => session[:postcode]).within(current_user.range_to , :origin => session[:postcode])
      elsif params.has_key?(:all)
        @users = User.all
      elsif params.has_key?(:rating)
        @users = User.all.sort_by(&:av_rating).reverse
      else
        flash[:alert] = "** Postcode not valid **"
        @users=User.all
      end
    rescue
      @users = User.all.order("created_at DESC")
      flash[:alert] = "** Bad Search Parameters **"
    end
    ensure
      render 'index'
  end

  def postcode_added
    @current_user = current_user
    session[:postcode]=params[:user][:postcode]
    if valid_postcode(session[:postcode])
      begin
      @users = User.by_distance(:origin => session[:postcode]).within(current_user.range_to , :origin => session[:postcode])
      rescue
      @users = User.all
      flash[:alert] = "** Bad Search Parameters **"
      end
    else
      @users = User.search(session[:postcode]).order("created_at DESC")
    end
  ensure
    render 'index'
  end

  def show
    @image=Image
    @user = User.find(params[:id]) || guest_user
    @current_user = current_user
    @reviews = Review.where("user_id = #{@user.id}").order("created_at ASC")
    @review = Review.new
  end

  def edit
    @current_user = current_user
    @user = User.find(params[:id])
  end

  def update
    binding.pry
    @current_user = current_user
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

  def valid_postcode (postcode)
    postcode.match(/\b((?:(?:gir)|(?:[a-pr-uwyz])(?:(?:[0-9](?:[a-hjkpstuw]|[0-9])?)|(?:[a-hk-y][0-9](?:[0-9]|[abehmnprv-y])?)))) ?([0-9][abd-hjlnp-uw-z]{2})\b/)? true : false
  end
    

  private
    def user_params
      params.require(:user).permit(:email, :bio, :avatar, :user_id, :id, :range_to, :location_lat, :location_lon, :search, :is_a_chef, :is_chef?, :max_party_size, :price_per_head, :postcode, :format)
    end

end
