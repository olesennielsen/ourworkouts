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
    number_of_days = 14
    
    # events for the timeline
    groups = current_user.groups    
    
    @timeline_events = Event.where(:group_id => current_user.group_ids).where('start_time BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day + number_of_days + 1)

    if @timeline_events.empty?
      return_value += "<br /><h2>Hi there,</h2><h3>your group haven't created any workouts yet, so go to your group's "
      return_value += link_to "calendar", events_path
      return_value += ' and create kickass workouts or '
      return_value += link_to "invite", new_user_invitation_path
      return_value += ' your friends and colleagues to join your group on ourworkouts.com</h3><br /><br />'
    else      
      # return of the html used in the timeline
      return_value += '<div id="timeline-container">'
      @all_events_query = Event.where(:group_id => current_user.group_ids)
      @all_event_hash = []
      for event in @all_events_query
        @all_event_hash << event.title
      end
      
      counter = 6
      
      (DateTime.now.beginning_of_day..DateTime.now.end_of_day + number_of_days).each do |day|
        @todays_events = Event.where(:group_id => current_user.group_ids).where('start_time BETWEEN ? AND ?', day, day + 1)
        
        if @todays_events.empty?
          return_value += '<div class="no-event" id="' + day.to_date.to_s + '" style="left:' + counter.to_s + '%">&nbsp;</div>'
        else
          number_of_events = @todays_events.size
          if number_of_events > 3
            number_of_events = 3
          end
          
          height = number_of_events * 100.0 / 3.0
          if Event.contain_goal_event(@todays_events)
            return_value += '<div class="event" id="' + day.to_date.to_s + '" style="height:' + height.to_s + '%;min-height:' + height.to_s + '%;left:' + counter.to_s + '%;background-color:red;opacity:0.55;filter:alpha(opacity=55);">&nbsp;</div>'
          else
            return_value += '<div class="event" id="' + day.to_date.to_s + '" style="height:' + height.to_s + '%;min-height:' + height.to_s + '%;left:' + counter.to_s + '%">&nbsp;</div>'
          end
        end
        counter += 6        
      end

      return_value += '</div><div id="timeline-bar">&nbsp;</div><hr /><br />'
      
    end 
    return return_value.html_safe

  end
end
