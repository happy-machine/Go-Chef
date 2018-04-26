class ApplicationMailer < ActionMailer::Base
  def welcome_email
    mail(to: params[:user].email,
         body: "You have an email from #{current_user}\n #{params[:email_body]}",
         content_type: "text/html",
         subject: "Go Chef! Email from #{current_user}")
  end
end
