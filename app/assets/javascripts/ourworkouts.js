$(document).ready(function() {
	$('#facebook-link').click(function(event){
		if( !$("#group_name").val()){
			alert('Please enter a group name');
			event.preventDefault(); // Prevent link from following its href		
		} else {
			event.preventDefault(); // Prevent link from following its href	
			window.location = $(this).attr('href') + "&state=" + "ow.com" + $("#group_name").val();				
		}
	});
	
	$('#twitter-link').click(function(event){
		if( !$("#group_name").val()){
			alert('Please enter a group name');
			event.preventDefault(); // Prevent link from following its href		
		} else {
			event.preventDefault(); // Prevent link from following its href	
			window.location = $(this).attr('href') + "&state=" + "ow.com" + $("#group_name").val();				
		}
	});
	
	$('#google-link').click(function(event){
		if( !$("#group_name").val()){
			alert('Please enter a group name');
			event.preventDefault(); // Prevent link from following its href		
		} else {
			event.preventDefault(); // Prevent link from following its href	
			window.location = $(this).attr('href') + "&state=" + "ow.com" + $("#group_name").val();				
		}
	});
	
	$('#linkedin-link').click(function(event){
		if( !$("#group_name").val()){
			alert('Please enter a group name');
			event.preventDefault(); // Prevent link from following its href		
		} else {
			event.preventDefault(); // Prevent link from following its href	
			window.location = $(this).attr('href') + "&state=" + "ow.com" + $("#group_name").val();				
		}
	});
});