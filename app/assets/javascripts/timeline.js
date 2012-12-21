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
		var date = this.id;

		if (hideTimer)
			clearTimeout(hideTimer);

		var pos = $(this).offset();
		var width = $(this).width();
		container.css({
			left: (pos.left + width + 2) + 'px',
			top: pos.top - 5 + 'px'
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
