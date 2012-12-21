$(function() 
{
	var hideDelay = 50;  
	var hideTimer = null;

	var container = $('<div id="eventPopupContainer">'
	+ '<div id="eventPopupContent"></div>'
	+ '</div>');

	$('body').append(container);

	$('.event').live('mouseover', function()
	{
		var current_time = new Date();
		var current_day = current_time.getDate();
		
		var date = this.id;
		var day_of_event = date.substring(8,10);
		
		var difference = day_of_event - current_day;
		
		if (difference < 0) 
			difference = 30 + difference;
			
		if (hideTimer)
			clearTimeout(hideTimer);  	
		
		var pos = $(this).offset();
		var width = $(this).width();
		
		var container_left = 0;
		var container_top = 0;
		
		if (difference > 7) {
			container_left = pos.left - 200 - 14;
		} else {
			container_left = (pos.left + width + 2);			
		}
		
		container_top = pos.top - 5;
		container.css({
			left: container_left + 'px',
			top: container_top + 'px'
		});

		$('#eventPopupContent').html('&nbsp;');

		$.ajax({
			type: 'GET',
			url: '/get_by_date/' + date,
			success: function(data)
			{
				var date_events = '<h4>Events on ' + date + '</h4><hr />';
				$.each(data, function(i, item) {
					var datestr = item.start.substring(11, 16);
					
					date_events += '<p><strong><a href="/events/' + item.id +'">' + item.title + '</a></strong> at ';
					date_events += datestr + '<br />';
					date_events += item.entries + ' have already joined</p><br />';
				});

				$('#eventPopupContent').html(date_events);
			}
		});

		container.css('display', 'block');
	});

	$('.event').live('mouseout', function()
	{
		if (hideTimer)
			clearTimeout(hideTimer);
	hideTimer = setTimeout(function()
	{
		container.css('display', 'none');
		}, hideDelay);
	});

	// Allow mouse over of details without hiding details
	$('#eventPopupContainer').mouseover(function()
	{
		if (hideTimer)
		clearTimeout(hideTimer);
	});

	// Hide after mouseout
	$('#eventPopupContainer').mouseout(function()
	{
		if (hideTimer)
		clearTimeout(hideTimer);
		hideTimer = setTimeout(function()
		{
			container.css('display', 'none');
		}, hideDelay);
	});
});
