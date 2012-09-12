module HomeHelper
  
  def show_sports(group)
    return_value = ''
    sports = group.sports
    
    sports.each do |sport|
      return_value += "<p>" + sport.name + "</p>"
    end
    return return_value.html_safe
  end
  
end
