module ApplicationHelper

  def short_date(date)
    date.strftime("%b %d '%y")
  end

end
