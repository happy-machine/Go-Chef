# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  #POST /resource/sign_in
  def create
    super
    if session[:user_type] == "guest"
      session[:user_type] = "registered"
      #User.where(name: "guest").destroy_all
      redirect_to '/index'
    end
  
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute, :user, :email, :params])
  end
end
