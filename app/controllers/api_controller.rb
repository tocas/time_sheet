class ApiController < ApplicationController
  def create
    post_data = request.body.read
    @user = User.where(["email = ?", params[:user]]).first
    logger.debug post_data
    data = JSON.parse(post_data)
    logger.debug data
    @work = @user.works.build(JSON.parse(post_data))
    if @work.save 
      logger.debug "User saved"
    else
      logger.debug "NOT SAVE"
    end
    logger.debug "The user is #{@user}"
    
    
  end
end
