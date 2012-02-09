class WorksController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :admin?, :only => [:all_work]
  before_filter :find_work, :only => [:show, :edit, :update, :destroy]
  # GET /works
  # GET /works.xml
  def index
    @title = "List of my work"
   
    if !params["date"]
      @month = Time.now.month
      @year  = Time.now.year
    else
      date = params["date"]
      @month = date["month"].to_i
      @year = date["year"].to_i
    end
    @day = Date.new(@year,@month,1)
    @days = (@day.beginning_of_month..@day.end_of_month ).to_a
    
    @works = current_user_work(@day.beginning_of_month,@day.end_of_month)
     
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @works }
    end
  end

  # GET /works/1
  # GET /works/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work }
      format.json { render :json => @work}
      format.pdf do
        pdf = PDF::Writer.new
        pdf.text "test"
        send_data pdf.render, :filename => 'products.pdf', :type => 'application/pdf', :disposition => 'inline'
      end
    end
  end

  # GET /works/new
  # GET /works/new.xml
  def new
    @title = "New work"
     @attr = { 
        :day => Date.today.to_s() , 
        :description => "", 
        :time => nil,
        :user_id => nil 
      }
    
    
    if params["day"]
      @attr = @attr.merge(:day => params["day"])
    end
    @work = Work.new(@attr)
    
    
    fill_ext_work

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
  # POST /works.xml
  def create
    @work = current_user.works.build(params[:work])

    respond_to do |format|
      if @work.save
        format.html { redirect_to(@work, :notice => 'Work was successfully created.') }
        format.xml  { render :xml => @work, :status => :created, :location => @work }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /works/1
  # PUT /works/1.xml
  def update
    respond_to do |format|
      if @work.update_attributes(params[:work])
        format.html { redirect_to(@work, :notice => 'Work was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.xml
  def destroy
    @work.destroy

    respond_to do |format|
      format.html { redirect_to(works_url) }
      format.xml  { head :ok }
    end
  end
  
  def all_work
    @works = Work.all
  end
  
  private
  
    def find_work
      @work = current_user.works.find(params[:id])
    end
    
    def current_user_work(start_day,stop_day)
      @work = current_user.works.find(:all, :conditions => [ "day >= ? AND day <= ?", start_day, stop_day], :order => "day")
    end
    
    
    def fill_ext_work
      if current_user.settings.where('settings.name' => 'Pivotal Tracker').first.enabled
        PivotalTracker::Client.token = current_user.settings.where('settings.name' => 'Pivotal Tracker').first.APIkey
        @project = PivotalTracker::Project.find(242503)
        #pivotal tracker
        @activity = @project.activities.all
        @today_activity =  @activity.select {|a| a.occurred_at > @work.day}
        if @today_activity.nil?
          @work.description = "Nil"
        else
          @description = ""
          @today_activity.each {|activity| @description += activity.description + "\n"}
          @work.description = @description.to_s()
        end
      end
      
    end
    
    def admin?
      if !current_user.admin?
       redirect_to root_path, :notice => "Please sign in as admin to access this page."
      end
    end
end
