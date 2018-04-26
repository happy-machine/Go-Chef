# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  #POST /resource/sign_in
  def create
=begin
    puts "session"
    puts params[:user][:email]
    current_user=User.find_by(email: params[:user][:email])
    puts params
    puts "and user"
    p current_user
    puts current_user.name
    puts session[:user_type]
=end
    if session[:user_type]=="guest"
      session[:user_type]="registered"
      redirect_to '/index'
    end
     super
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
