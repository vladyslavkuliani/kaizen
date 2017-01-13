class ManagerMailer < ApplicationMailer
  default from: 'kaizenapp123@gmail.com'

  def welcome_email(manager)
   @manager = manager
   @url  = 'http://desolate-spire-13116.herokuapp.com/'
   mail(to: @manager.email, subject: 'Welcome to Kaizen!')
  end
end
