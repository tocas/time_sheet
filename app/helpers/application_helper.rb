module ApplicationHelper
  def title                                          
    base_title = "Time Sheet"  
    if @title.nil?                                    
      base_title                    
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("logo.png", :alt => "Time Sheet App", :class => "round")
  end
  

end
