module ApplicationHelper
  def show_tips
    return_value = ''
    counter = 1
    
    @tips.each do |tip|
      if counter%2 == 1
        return_value += '<div class="row-fluid">' + show_tip(tip)
        counter += 1
      else
        return_value += show_tip(tip) + '</div><br />'
        counter += 1
      end
    end
    
    if counter%2 == 1
      return_value += '</div><br />'
    end
    
    return return_value.html_safe
  end
  
  def show_tip(tip)
    return_value = ''
    return_value += '<div class="span6" id="workout_tip"><h2>' + tip.title + '</h2><br /><p class="pull-right>"'     
    return_value += tip.tip_date.to_formatted_s(:long) + '</p>' + '<br /><p>' + tip.body + '</p>'
    return_value += '<br /><p class="pull-right">Tip by ' + tip.author + '</p></div>'
    return return_value
  end
end
