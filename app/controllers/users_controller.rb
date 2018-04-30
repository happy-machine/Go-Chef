class UsersController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show] 

  def index
    @current_user=current_user
      @users= User.all
  end

  def search
    @current_user=current_user
    if params.has_key?(:name)
      @users = User.search(session[:postcode]).order("created_at DESC")
    elsif params.has_key?(:location)
      @users = User.by_distance(:origin => session[:postcode]).within(current_user.range_to , :origin => session[:postcode])
    elsif params.has_key?(:all)
      @users = User.all
    elsif params.has_key?(:rating)
      @users = User.all.sort_by(&:average_rating).reverse
    else
      if session[:postcode].length == 6 || session[:postcode].length == 7
        begin
          @users = User.by_distance(:origin => session[:postcode]).within(current_user.range_to , :origin => session[:postcode])
          rescue
          @users = User.all
          flash[:error] = "** Postcode not valid **"
          end
      else
        @users = User.search(session[:postcode]).order("created_at DESC")
      end
      @users = User.all.order("created_at DESC")
    end
  ensure
    render 'index'
  end

  def postcode_added
    @current_user = current_user
    session[:postcode]=params[:user][:postcode]
    puts session[:postcode].length
    if session[:postcode].length == 6 || session[:postcode].length == 7
      begin
      @users = User.by_distance(:origin => session[:postcode]).within(current_user.range_to , :origin => session[:postcode])
      rescue
      @users = User.all
      flash[:error] = "** Postcode not valid **"
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

  def test
    session[:test_mode]= !session[:test_mode]
    @testmode = session[:test_mode]
    render 'test'
  end

  def update
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

  private
    def user_params
      params.require(:user).permit(:email, :bio, :avatar, :user_id, :range_to, :location_lat, :location_lon, :search, :is_a_chef, :max_party_size, :price_per_head, :postcode, :format)
    end

end
