module HomeHelper
  
  def show_sports(group)
    return_value = ''
    sports = group.sports
    
    sports.each do |sport|
      return_value += image_tag(sport.link, :alt => sport.name, :title => sport.name, :class => 'sport-pictogram')
    end
    return return_value.html_safe
  end
  
end
