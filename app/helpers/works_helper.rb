module WorksHelper
  def minutes_to_hours(minutes)
    loggler.debug minutes
    (minutes / 60).round(2)
  end
end
