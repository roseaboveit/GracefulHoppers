class Notifier < ActionMailer::Base
  default from: "graceful.hoppers@gmail.com"

  def introduction(user)
    @user = user
    mail to: @user.email, subject: 'Welcome to Graceful Hoppers!'
  end
end
