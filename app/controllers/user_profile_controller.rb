class UserProfileController < ApplicationController
    
    def show
        @user=User.find(params[:id])
      end

          
    def save
        @user=User.find_by(email:params[:user][:email])
        @user.update_attributes(email: params[:user][:email], bio: params[:user][:bio])
        redirect_to ('/')
      end

end
