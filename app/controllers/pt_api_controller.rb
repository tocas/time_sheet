# encoding: utf-8
class PtApiController < ApplicationController
  def index
    post_data = request.body.read
    doc = XML::Document.string(post_data, :encoding => XML::Encoding::UTF_8)
    @activity_id = rand(10000.99999)
    @project_id = doc.find('//project_id/text()')[0]
    @story_id = doc.find('//story/id/text()')[0]
    @description = doc.find('//description/text()')[0]
    @date = parse_date(doc.find('//occurred_at/text()')[0])
    user_name = doc.find('//author/text()')[0]
    logger.debug user_name
    setting = Setting.where("pt_name = ?", user_name.to_s).first
    @user = setting.user    
    @pt = PtActivity.new(:activity_id => @activity_id, 
                         :project_id => @project_id.content, 
                         :story_id => @story_id.content, 
                         :description => @description.content, 
                         :day => @date,
                         :user => @user.email,
                         :fill_in => false)
    
    if @pt.save
      UserMailer.log_time(@user,@pt).deliver
      send_xmpp
    end    
  end
  
  private
    def parse_date(pt_date)
      day = pt_date.to_s.split(' ')[0]
      Date.strptime(day, '%Y/%m/%d')
    end
    
    def send_xmpp
      p "Sendig XMPP"
      # Login
      jid = Jabber::JID::new('secretarytimesheet@gmail.com')
      password = '7IAgfyDpWq67'
      cl = Jabber::Client::new(jid)
      cl.connect
      cl.auth(password)

      # Create a message
      to = @user.email
      subject = "Time-Sheet"
      body = "Tvuj klient nepodportuje HTML."
      m = Jabber::Message::new(to, body).set_type(:normal).set_id('1').set_subject(subject)

      # Create the html part
      h = REXML::Element::new("html")
      h.add_namespace('http://jabber.org/protocol/xhtml-im')

      # The body part with the correct namespace
      b = REXML::Element::new("body")
      b.add_namespace('http://www.w3.org/1999/xhtml')

      html_message = "Jak dlouho jste stravil na ukolu " + @pt.description + "<br />
      <a href='http://time-sheet.heroku.com/api/log-time/" + @pt.activity_id.to_s + "/30?user=" + @user.email + "'>0.5 hod.</a><br />
      <a href='http://time-sheet.heroku.com/api/log-time/" + @pt.activity_id.to_s + "/60?user=" + @user.email + "'>1 hod.</a>
      <a href='http://time-sheet.heroku.com/api/log-custom-time/" + @pt.activity_id.to_s + "?user=" + @user.email + "'>Vlastní čas</a>"
      
      # The html itself
      t = REXML::Text.new(html_message, false, nil, true, nil, %r/.^/ )

      # Add the html text to the body, and the body to the html element
      b.add(t)
      h.add(b)

      # Add the html element to the message
      m.add_element(h)

      # Send it
      cl.send m
    end
end
