class SettingsController < ApplicationController
  # GET /settings
  # GET /settings.xml
  
  
  before_filter :authenticate_user!
  before_filter :find_settings, :only => [:edit, :update]
  before_filter :set_title
  
  def index
    @setting = current_user.setting
    if @setting.nil? 
      redirect_to new_setting_path
      return
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @setting }
    end
  end
  
  def show
    redirect_to settings_path
  end

  # GET /settings/new
  # GET /settings/new.xml
  def new
    @setting = Setting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /settings/1/edit
  def edit

  end

  # POST /settings
  # POST /settings.xml
  def create
    @setting = current_user.build_setting(params[:setting])

    respond_to do |format|
      if @setting.save
        format.html { redirect_to(@setting, :notice => 'Setting was successfully created.') }
        format.xml  { render :xml => @setting, :status => :created, :location => @setting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /settings/1
  # PUT /settings/1.xml
  def update
    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        format.html { redirect_to(@setting, :notice => 'Setting was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  private
    def find_settings
      @setting = current_user.setting
    end
    
    def set_title
      @title = "Settings"
    end
end
