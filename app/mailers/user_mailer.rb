class UserMailer < ApplicationMailer
    def welcome_email(user,current_user,body)
        mail(to: user.email,
             body: "You have an email from #{current_user.email}\n #{body}",
             content_type: "text/html",
             subject: "Go Chef! Email from #{current_user.name}")
      end
end
