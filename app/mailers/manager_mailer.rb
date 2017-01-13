class ManagerMailer < ApplicationMailer
  default from: 'kaizenapp123@gmail.com'

  def welcome_email(manager)
   @manager = manager
   @url  = 'http://localhost:3000/login'
   mail(to: @manager.email, subject: 'Welcome to Kaizen!')
  end
end
