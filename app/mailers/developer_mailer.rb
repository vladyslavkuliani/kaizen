class DeveloperMailer < ApplicationMailer

  def notice_email(developer)
   @developer = developer
   @url  = 'http://localhost:3000/login'
   mail(to: @developer.email, subject: 'You are assigned a new task!')
  end
  
end
