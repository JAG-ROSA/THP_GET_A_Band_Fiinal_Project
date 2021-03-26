module AvailabilitiesHelper
  def is_available?(date)
    available = []
    non_available = []
    @availabilities.each do |availability|
      availability.start_date > date || availability.end_date < date ? non_available << date : available << date
    end
    if available.empty?
      content_tag :p, class: "calendar-day text-danger text-center", data: { date: date } do
        non_available.empty? ? date.strftime("%d/%m") : non_available[0].strftime("%d/%m")
      end
    else
      content_tag :p, class: "calendar-day text-success text-center", data: { date: date } do
        available[0].strftime("%d/%m")
      end
    end
  end
end
