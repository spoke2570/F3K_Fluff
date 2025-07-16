# F3K_Fluff_Mode_Based
Sport flyer widget for FrSky ETHOS
![image](https://github.com/user-attachments/assets/a675d41b-7c95-4f4e-acc6-21a6705cfb25)


Thanks for looking at my F3K sport flyer widget. This guy was made to work with my own planes and I hope can be useful Ito others. Sorry Only in english with Si units, so meters and seconds are primary. Feel free to lift any part of this for whatever use.

Features of this widget are:
	1) Current flight information on the top row (resets with a new launch)
 	2) Flight session maximums in the left panel 
  	3) Flight session averages in the rigth panel with number of flights recorded
   	4) Last 10 or 13 flights information in the center panel
    	5) Ability to shut down radio and rejoin the previous session on restart (yep I gotta answer nature's call, too).
     		*** This feature is unregulated at this point and is only intended for a daily session. Use for too many launches could overwhelm your system. So far I have run it at more than 60 flights with no problems. 
       6) Displays reciver voltage when connected and transmitter voltage when not. 
       
I have tested this to be pretty robust even when a new model with no flight modes or timers or telemetry is chosen. (Of course you would not want that sort of set up).

This widget assumes that you have your model set up to have "launch" and "zoom" flight modes (defined below), a flight timer, and an altitude sensor that will keep maximum altitudes. Mine are all FrSky reciever based. 

To work this needs from you (or it won't work):

	a) Flight timer source  
	b) Altitude source  
	c) Launch mode (mode that says you are going to throw the plane)  
	d) Zoom mode (last mode before regular flight). I assume this one ends as the model is being nosed over into level flight.  
 		*** NOTE: Launch and zoom can be the same mode, but if they are different it is best ot set thins up like that. 
  
Choices you will find in the congfigure screen:  

	a) Flight timer source -> I am assuming here that you have a flight timer you like, so I want to provide information from it. This must exist.  
	b) Work timer source -> Maybe you have one you like. Maybe you want it to be a sum of your flight times. Maybe you want mine that runs when the reciever is connected.  
	c) Launch mode source -> Mode that says you ar going to throw the plane. This must exist.  
	d) Zoom mode source -> Last mode before regular flight. This must exist but can be same and launch mode.  
	e) Altidude sensor -> Defaults to whatever FrSky sensor is named "altitude". This must exist.   
	f) Minimum altitude for good launch ->  This is the altiude when coming out of zoom. If it is too low the flight will not be recorded in the widget.  
	g) Play minutes -> This allows you to silence the calling of the whole minutes of your flight. It is arranged so that it will not play the seconds, only the minute increments of the flinght, eg. "1 min".."2 min"...  
 
The widget was built for an X20S full window, or largest window (with the system header and footer). The simulators show that it will work in most screen sizes. If it does not feel free to modify the code and repost it. 
 
The widget reports current flight conditions in the top row (largest font): Flight time,  Launch height, Launch drop, Current altitude, Maximum altitude.  

The widget (in full screen) shows values from the previous 13 flights: Flight time, Launch height, Launch drop, Maximum altitude. These appear in the green background box, center screen.  

On the left side there are flight maximums listed: Best flight time, Best launch height, Least launch drop. The work timer is at the bottom of this panel.  

On the right side there are flight averages: Average flight time, Average launch height, Average launch drop. The bottom 2 slots in the colume are filled with the flight mode, and the reciever voltage (assuming the reciever is being run off of pack voltage and not a BEC).  

Launch height is defined as the maximum altitude atained in the 3 seconds after leaving the last flight mode before normal flight, eg zoom.  

Launch drop is defined as the difference between the launch height and the altitue at 3 seconds after last flight mode before normal flight.  
	
