class ApplicationController < ActionController::Base
  def current_user
    super || guest_user
  end

  private

  def guest_user
    session[:guest_user_id]=nil
   User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  end

  def create_guest_user
    u = User.create(:name => "guest", :email => "guest_#{Time.now.to_i}#{rand(99)}@example.com")
    u.save(:validate => false)
    u
  end

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :location_lat, :location_lon, :range_to, :avatar, :is_a_chef, :max_party_size, :price_per_head] )
  end
end
