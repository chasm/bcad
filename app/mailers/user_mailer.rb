class UserMailer < ActionMailer::Base
  default from: "info@bridgecityautobrokers.com"
  
  def reset_email(user, request)
    @user = user
    @url  = "#{request.protocol}#{request.host}/reset/#{@user['code']}"
    puts @url
    mail(
      :to => user["email"],
      :subject => "Reset your credentials for Bridge City Automotive"
    )
  end
end
