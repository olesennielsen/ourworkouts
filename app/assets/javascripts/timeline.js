$(document).ready(function() 
{
	var hideDelay = 500;  
  	var hideTimer = null;
	
	var container = $('<div id="eventPopupContainer">'
	+ '<div id="eventPopupContent>"'
	+ '</div>'
	+ '</div>'
	);
	
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
			data: 'page=' + pageID + '&guid=' + currentID,
			success: function(data)
			{
				$('#eventPopupContent').html(data.title);
			}
		});

		container.css('display', 'block');
	});
/*	
	


	

	

	$('.personPopupTrigger').live('mouseout', function()
	{
		if (hideTimer)
		clearTimeout(hideTimer);
		hideTimer = setTimeout(function()
		{
			container.css('display', 'none');
			}, hideDelay);
		});

		// Allow mouse over of details without hiding details
		$('#personPopupContainer').mouseover(function()
		{
			if (hideTimer)
			clearTimeout(hideTimer);
		});

		// Hide after mouseout
		$('#personPopupContainer').mouseout(function()
		{
			if (hideTimer)
			clearTimeout(hideTimer);
			hideTimer = setTimeout(function()
			{
				container.css('display', 'none');
				}, hideDelay);
			});
		});

*/
});