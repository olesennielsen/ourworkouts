$(function() 
{
	var hideDelay = 50;  
	var hideTimer = null;

	var container = $('<div id="eventPopupContainer">'
	+ '<table width="" border="0" cellspacing="0" cellpadding="0" align="center" class="eventPopupPopup">'
	+ '<tr>'
	+ '   <td class="corner topLeft"></td>'
	+ '   <td class="top"></td>'
	+ '   <td class="corner topRight"></td>'
	+ '</tr>'
	+ '<tr>'
	+ '   <td class="left">&nbsp;</td>'
	+ '   <td><div id="eventPopupContent"></div></td>'
	+ '   <td class="right">&nbsp;</td>'
	+ '</tr>'
	+ '<tr>'
	+ '   <td class="corner bottomLeft">&nbsp;</td>'
	+ '   <td class="bottom">&nbsp;</td>'
	+ '   <td class="corner bottomRight"></td>'
	+ '</tr>'
	+ '</table>'
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
			left: (pos.left + width) + 'px',
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
					var datestr = item.start.substring(0, 22);
					
					date_events += '<p><strong><a href="' + item.url +'">' + item.title + '</a></strong><br />'
					date_events += datestr;					
					date_events += '</p><br />';
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
