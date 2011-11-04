$(document).ready(function(){
    $("#flash100x100").each( function()
	{
		swfobject.embedSWF("swf-debug/ASDevsMVC.swf", "flash100x100", "100%", "100%", "10.0", "swf/playerProductInstall.swf", 
		{ 
			config: 'xml/application.xml', 
			debug: 'false' 
		}, 
		{ 
			wmode: 'opaque', 
			allowfullscreen: 'true' 
		}, 
		{ 
			id:"flash100x100", 
			name: "flash100x100",
			bgcolor: "#000000"
		});
    });
});