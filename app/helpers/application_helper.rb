module ApplicationHelper
  def show_star_rating(rating)
    empty_star_icon = "far fa-star"
    half_star_icon = "fas fa-star-half-alt"
    full_star_icon_name = "fas fa-star"

    round_by_half = (rating * 2.0).round / 2.0
    total_stars = Array.new(round_by_half, full_star_icon_name)
    total_stars += [half_star_icon] if round_by_half - round_by_half.to_i == 0.5
    total_stars += Array.new(5 - total_stars.size, empty_star_icon)
    
  end
  include Pagy::Frontend
end
