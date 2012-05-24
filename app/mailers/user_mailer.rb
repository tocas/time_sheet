class UserMailer < ActionMailer::Base
  default :from => "time@time-sheet.com"
  
  def log_time(user, activity)
    @user = user
    @activity = activity
    if Rails.env.production?
      @url30 = 'http://time-sheet.heroku.com/api/log-time/' + @activity.activity_id.to_s + '/30?user=' + @user.email
      @url60 = 'http://time-sheet.heroku.com/api/log-time/' + @activity.activity_id.to_s + '/60?user=' + @user.email
      @custom = 'http://time-sheet.heroku.com/api/log-custom-time/' + @activity.activity_id.to_s + '?user=' + @user.email
    else
      @url30 = 'http://localhost:3000/api/log-time/' + @activity.activity_id.to_s + '/30?user=' + @user.email
      @url60 = 'http://localhost:3000/api/log-time/' + @activity.activity_id.to_s + '/60?user=' + @user.email
      @custom = 'http://localhost:3000/api/log_custom_time/' + @activity.activity_id.to_s  + '?user=' + @user.email
    end
    mail(:to => user.email, :subject => 'Vyplnte prosim vykaz')
  end

end
