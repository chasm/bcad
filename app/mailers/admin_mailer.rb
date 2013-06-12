class AdminMailer < ActionMailer::Base
  default from: "info@bridgecityautobrokers.com"
  
  def reset_email(admin, request)
    @admin = admin
    @url  = "#{request.protocol}#{request.host}/reset/#{@admin['code']}"
    puts @url
    mail(
      :to => admin["email"],
      :subject => "Reset your credentials for Bridge City Automotive"
    )
  end
end
