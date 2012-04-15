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
    @activity = PtActivity.where("activity_id = ? AND fill_in = ?", @activity_id, false).first
    @user = User.where(["email = ?", params[:user]]).first
    if @activity && @user
      logger.debug "true"
      @work = @user.works.build(:day => @activity.day, :description => @activity.description, :time => @time, :project_id => @activity.project_id, :story_id => @activity.story_id)
      if @work.save
        @activity.fill_in = true
        if @activity.save
          logger.debug "Work saved"
          @message = "Prace byla ulozena"
        end
      else
        @message = "Neulozeno"
        logger.debug "NOT SAVE"
      end
    else
        @message = "Neulozeno, aktivita nebo uzivatel nenalezen."
        logger.debug "NOT SAVE"
    end
  end
  
  def send_message
    im = Jabber::Simple.new("secretarytimesheet@gmail.com", "7IAgfyDpWq67")
    im.deliver("tomaslucovic@gmail.com", "Ahoj kamarade")
  end
end
