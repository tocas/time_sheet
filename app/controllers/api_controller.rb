# encoding: utf-8
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
  
  def log_custom_time
    @activity_id = params[:activity_id]
    @activity = PtActivity.where("activity_id = ? AND fill_in = ?", @activity_id, false).first
    @user = User.where(["email = ?", params[:user]]).first
    redirect_to new_works_path(:project_id => @activity.project_id, :story_id => @activity.story_id, :description => @activity.description)
  end
  
  def send_message
    #im = Jabber::Simple.new("secretarytimesheet@gmail.com", "7IAgfyDpWq67")
    #im.deliver("tomaslucovic@gmail.com", "<a href='localhost:3000'>Localhost</a>")

    # Login
    jid = Jabber::JID::new('secretarytimesheet@gmail.com')
    password = '7IAgfyDpWq67'
    cl = Jabber::Client::new(jid)
    cl.connect
    cl.auth(password)

    # Create a message
    to = "tomaslucovic@gmail.com"
    subject = "XMPP4R Rich-Text Test"
    body = "Wow, I can do HTML now. But if you see this, your client doesn't support it"
    m = Jabber::Message::new(to, body).set_type(:normal).set_id('1').set_subject(subject)

    # Create the html part
    h = REXML::Element::new("html")
    h.add_namespace('http://jabber.org/protocol/xhtml-im')

    # The body part with the correct namespace
    b = REXML::Element::new("body")
    b.add_namespace('http://www.w3.org/1999/xhtml')

    # The html itself
    t = REXML::Text.new( "This is so <a href='http://www.seznam.cz'>Seznam</a>", false, nil, true, nil, %r/.^/ )

    # Add the html text to the body, and the body to the html element
    b.add(t)
    h.add(b)

    # Add the html element to the message
    m.add_element(h)

    # Send it
    cl.send m
  end
end
