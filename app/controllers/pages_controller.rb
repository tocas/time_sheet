class PagesController < ApplicationController
  def home
    if current_user 
      redirect_to works_path
    end
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end
  
end
