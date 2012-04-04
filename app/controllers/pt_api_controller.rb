class PtApiController < ApplicationController
  def index
    post_data = request.body.read
    doc = XML::Document.string(post_data, :encoding => XML::Encoding::UTF_8)
    @activity_id = rand(10000.99999)
    @project_id = doc.find('//project_id/text()')[0]
    @story_id = doc.find('//story/id/text()')[0]
    @description = doc.find('//description/text()')[0]
    @date = parse_date(doc.find('//occurred_at/text()')[0])
    logger.debug @date
    @user = User.where(["email = ?", "tomaslucovic@gmail.com"]).first
    
    @pt = PtActivity.new(:activity_id => @activity_id, 
                         :project_id => @project_id.content, 
                         :story_id => @story_id.content, 
                         :description => @description.content, 
                         :day => @date,
                         :user => @user.email)
    
    if @pt.save
      UserMailer.log_time(@user,@pt).deliver
    end    
  end
  
  private
    def parse_date(pt_date)
      day = pt_date.to_s.split(' ')[0]
      Date.strptime(day, '%Y/%m/%d')
    end
end
