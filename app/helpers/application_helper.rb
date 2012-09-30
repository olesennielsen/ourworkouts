module ApplicationHelper
  def show_tips
    return_value = ''
    counter = 1

    @tips.each do |tip|
      if counter%2 == 1
        return_value += '<div class="row-fluid">' + show_tip(tip)
        counter += 1
      else
        return_value += show_tip(tip) + '</div><br /><br />'
        counter += 1
      end
    end

    if counter%2 == 1
      return_value += '</div><br /><br />'
    end

    return return_value.html_safe
  end

  def show_tip(tip)
    return_value = ''
    return_value += '<div class="span6" id="workout-tip"><h2>' + tip.title + '</h2><br /><p>' + tip.body + '</p>'
    return_value += '<br /><p class="pull-right">Tip by ' + tip.author + '</p></div>'
    return return_value
  end

  def timeline
    return_value = ''
    # events for the timeline
    groups = current_user.groups
    @milestone_event = Event.where(:group_id => current_user.group_ids).where(:milestone => true).order("start_time DESC").first
  
    @days_to_milestone_event = (@milestone_event.start_time.to_time - Time.now).to_i / 1.day + 1

    @width_of_pillar = 62.0/@days_to_milestone_event
    @spacing_between_pillars = 30.0/(@days_to_milestone_event - 1)  

    # return of the html used in the timeline
    return_value += '<br /><br /><h1 class="pull-right" id="countdown">' + @days_to_milestone_event.to_s +  ' days to ' + @milestone_event.title + '</h1>
    <br /><br /><div class="row-fluid" id="timeline-container">'

    (DateTime.now.beginning_of_day..DateTime.now.end_of_day + @days_to_milestone_event - 1).each do |day|
      @todays_events = []
      groups.each do |group|
        tmp_events = Event.where(:group_id => group.id).where('start_time BETWEEN ? AND ?', day, day + 1)
        tmp_events.each do |te|
          @todays_events.push(te)
        end
        if @todays_events.empty?
          return_value += '<div class="no-event" id="' + day.to_date.to_s + '" style="width:' + @width_of_pillar.to_s + '%">&nbsp;</div>'
          return_value += '<div class="no-event" style="width:' + @spacing_between_pillars.to_s + '%">&nbsp;</div>'
        else
          return_value += '<div class="event" id="' + day.to_date.to_s + '" style="width:' + @width_of_pillar.to_s + '%">&nbsp;</div>'
          return_value += '<div class="no-event" style="width:' + @spacing_between_pillars.to_s + '%">&nbsp;</div>'
        end        
      end
    end
    
    return_value += '<div class="milestone-event" id="' + @milestone_event.start_time.to_date.to_s + '" style="width:' + @width_of_pillar.to_s + '%">&nbsp;</div>'
    
    return_value += '</div><div id="timeline-bar">&nbsp;</div><hr /><br />'

    return return_value.html_safe

  end
end
