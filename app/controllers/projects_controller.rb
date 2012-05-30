# encoding: utf-8
class ProjectsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_title
  # GET /projects
  # GET /projects.xml
  def index
    #@projects = Project.all
    PivotalTracker::Client.token = current_user.setting.pt_api_key
    logger.debug current_user.setting.pt_api_key
    @projects = PivotalTracker::Project.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show    
    PivotalTracker::Client.token = current_user.setting.pt_api_key
    @project = PivotalTracker::Project.find(params[:id].to_i)
    @stories = @project.stories.all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
  
  def story
    PivotalTracker::Client.token = current_user.setting.pt_api_key
    @project = PivotalTracker::Project.find(params[:project_id].to_i)
    @story = @project.stories.find(params[:story_id].to_i)
    @works = Work.where("project_id >= :project_id AND story_id <= :story_id", {:project_id => params[:project_id], :story_id => params[:story_id].to_i})
    @story_time = @works.map(&:time).inject(:+)
         
    respond_to do |format|
      format.html { render :action => "story" }
      format.xml  { head :ok }
    end
  end
  
  def overview
    PivotalTracker::Client.token = current_user.setting.pt_api_key
    @project = PivotalTracker::Project.find(params[:project_id].to_i)
    owner_email = @project.memberships.all.select{|x| x.role == "Owner"}.first.email
    @h ={}
    if current_user.email == owner_email
      @users = User.all
      @project.memberships.all.select{|x| x.role == "Owner"}
      @users.each do |user|
        works = Work.where(:project_id => params[:project_id], :user_id => user.id)
        time = works.present? ? works.sum(:time) : 0
        @h[user.email] = time
      end
    else 
      @users = [User.find(current_user.id)]
      works = Work.where(:project_id => params[:project_id], :user_id => current_user.id)
      time = works.present? ? works.sum(:time) : 0
      p time
      @h[current_user.email] = time
    end
    
    
     
  end
  
  private
    def set_title
      @title = "Projects"
    end
end
