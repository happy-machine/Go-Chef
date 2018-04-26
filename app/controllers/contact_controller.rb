class ContactController < ApplicationController

    def new
        puts 'yow'
        @current_user=current_user
        p params
        @user=User.find(params[:user_id])
        
    end

    def create
        @user=User.find(params[:user_id])
        UserMailer.welcome_email(@user,current_user,params[:body]).deliver
        @reviews = Review.where("user_id = #{params[:user_id]}").order("created_at ASC")
        @review = Review.new
        flash[:notice]="**Email Sent**"
        render 'users/show'
    end
end
