module AvailabilitiesHelper

  def is_available?(date)
    available = []
    non_available = []
    @availabilities.each do |availability|
      availability.start_date > date || availability.end_date < date ? non_available << date : available << date
    end
    if available.empty?
      content_tag :div, class: "calendar-day text-danger", data: {date: date} do
        non_available.empty? ? date.strftime('%d/%m/%y') : non_available[0].strftime('%d/%m/%y')          
      end
    else
      content_tag :div, class: "calendar-day text-success", data: {date: date} do
        available[0].strftime('%d/%m/%y')
      end
    end
  end
  
end
