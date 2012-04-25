module WorksHelper
  def format_time(time_in_minutes)
    p time_in_minutes
    minutes = time_in_minutes % 60
    hours = time_in_minutes / 60
    format("%02d:%02d", hours, minutes) #=> "01:00"
  end
  
  def day_time(works)

  end
end

