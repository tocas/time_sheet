class ActivityController < ApplicationController
  before_filter :authenticate_user!

  def index
    PivotalTracker::Client.token = "b841f65132a1d5eb80667b1d0b996e46"
    @project = PivotalTracker::Project.find(108702)	
    @externalwork = @project.activities.all
  end
end
