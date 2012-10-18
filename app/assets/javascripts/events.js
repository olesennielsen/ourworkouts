$(document).ready(function() {	
$('#event-message-form').hide(); //Initially form wil be hidden.
 $('#show-event-messages-form').click(function() {
  	$('#show-event-messages-form').hide();//Hides the button
	$('#event-message-form').show(1000);//Form shows on button click	
  });
});