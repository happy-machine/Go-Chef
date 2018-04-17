class UserProfileController < ApplicationController
    
    def show
        @user=User.find(params[:id])
      end

          
    def save
        @user=User.find_by(email:params[:user][:email])
        p 
        @user.update_attributes(email: params[:user][:email], bio: params[:user][:bio], avatar: params[:user][:avatar])
        redirect_to ('/')
      end

end
