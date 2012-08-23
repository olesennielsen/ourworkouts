$(document).ready(function() {

	var date = new Date();
	var d = date.getDate();
	var m = date.getMonth();
	var y = date.getFullYear();
	
	/*	Uses the pathname in the browser to retrieve
		the right athlete_id to create a path to the right
		event */
	var pathname = window.location.pathname;
	var match = pathname.match(/\d+/)
	
	if(match)
	{
		var athlete_id = parseInt(match[0], 10);
	}
	
	/*	Begin initializing and configurating the 
		calendar plugin */
	
	var calendar = $('#calendar').fullCalendar({
		editable: true,        
		header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek'
        },
		firstDay: 1,
        defaultView: 'month',
        height: 500,
        slotMinutes: 15,
        
        loading: function(bool){
            if (bool) 
                $('#loading').show();
            else 
                $('#loading').hide();
        },		
        
        /* 	This eventsource hits the right athletes eventcontroller on 
			the index action */
        eventSources: [{
            url: "/athletes/" + athlete_id + "/events/",
            color: '#51A351',
            textColor: 'white',
            ignoreTimezone: true
        }],
        
        timeFormat: 'h:mm t{ - h:mm t} ',
        dragOpacity: "0.5",
		
		selectable: true,
		selectHelper: true,
		
		/* 	This modal is used to create event directly in 
			calendar view using twitter-bootstraps modal plugin */
		select: function(start, end, allDay) {
			$('#myModal').modal();
			document.getElementById('event_starts_at').value = start
			document.getElementById('event_ends_at').value = end
			calendar.fullCalendar('unselect');
		},
        
        //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/event_ui/eventResize/
        eventResize: function(event, dayDelta, minuteDelta, revertFunc){
            updateEvent(event);
        },

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
          // would like a lightbox here.
        },
	});
});

	/* Hits the right controller and athlete with the update event */
function updateEvent(the_event) {
    $.update(
      "/athletes/" + the_event.athlete_id + "/events/" + the_event.id,
      { event: { title: the_event.title,
                 starts_at: "" + the_event.start,
                 ends_at: "" + the_event.end,
                 description: the_event.description
               }
      },
      function (reponse) { alert('successfully updated task.'); }
    );
};