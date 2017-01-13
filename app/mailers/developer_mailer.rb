class DeveloperMailer < ApplicationMailer

  def notice_email(developer)
   @developer = developer
   @url  = 'http://desolate-spire-13116.herokuapp.com/'
   mail(to: @developer.email, subject: 'You are assigned a new task!')
  end

end
