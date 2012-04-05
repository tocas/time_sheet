module WorksHelper
  def minutes_to_hours(minutes)
    logger.debug minutes    
    (minutes / 60).round(2)
  end
end
