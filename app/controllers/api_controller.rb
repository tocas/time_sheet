class ApiController < ApplicationController
  def create
    post_data = request.body.read
    @user = User.where(["email = ?", params[:user]]).first
    logger.debug JSON.parse(post_data)
    @work = @user.works.build(JSON.parse(post_data))
    if @work.save 
      logger.debug "User saved"
    else
      logger.debug "NOT SAVE"
    end
    logger.debug "The user is #{@user}"
  end
  
  def log_time
    @activity_id = params[:activity_id]
    @time = params[:time]
    @activity = PtActivity.where("activity_id = ?", @activity_id).first
    @user = User.where(["email = ?", "tomaslucovic@gmail.com"]).first
    @work = @user.works.build(:day => '2012-03-29', :description => @activity.description, :time => @time, :project_id => @activity.project_id, :story_id => @activity.story_id)
    logger.debug @wokr
    if @work.save 
      logger.debug "Work saved"
      @message = "Prace byla ulozena"
    else
      logger.debug "NOT SAVE"
    end
  end
end
