# F3K_Fluff_Mode_Based
Sport flyer widget for FrSky ETHOS larger screen radios

![image](https://github.com/user-attachments/assets/a675d41b-7c95-4f4e-acc6-21a6705cfb25)


Thanks for looking at my F3K sport flyer widget. This guy was made to work with my own planes and I hope can be useful to others. Sorry Only in english with Si units, so meters and seconds are primary. Feel free to lift any part of this for whatever use.

This widget assumes that you have your model set up to have "launch" and "zoom" flight modes (defined below), a flight timer, and an altitude sensor that will keep maximum altitudes. Mine are all FrSky reciever based. 

To work this needs from you (or it won't work):

	a) Flight timer source  
 
	b) Altitude source  
 
	c) Launch mode (mode that says you are going to throw the plane)  
 
	d) Zoom mode (last mode before regular flight). I assume this one ends as the model is being nosed over into level flight.  
 
  
Choices you will find in the congfigure screen:  

	a) Flight timer source -> I am assuming here that you have a flight timer you like, so I want to provide information from it. This must exist.  
 
	b) Work timer source -> Maybe you have one you like. Maybe you want it to be a sum of your flight times. Maybe you want mine that runs when RSSI is not 'zero'.  
 
	c) Launch mode source -> Mode that says you ar going to throw the plane. This must exist.  
 
	d) Zoom mode source -> Last mode before regular flight. This must exist.  
 
	e) Altidude sensor -> Defaults to whatever FrSky sensor is named "altitude". This must exist.   
 
	f) Minimum altitude for good launch ->  This is the altiude when coming out of zoom. If it is too low the flight will not be recorded in the widget.  
 
	g) Play minutes -> This allows you to silence the calling of the whole minutes of your flight. It is arranged so that it will not play the seconds, only the minute increments of the flinght, eg. "1 min".."2 min"...  
 

The widget was built for an X20S full window, or largest window (with the system header and footer), so I am unsure how it would look on a smaller screen. I can't imagine it will work well with less width. Screen locations are handled by what ever the system says the window size is. Font sizes are hard coded.   
 
The widget reports current flight conditions in the top row (largest font): Flight time,  Launch height, Launch drop, Current altitude, Maximum altitude.  

The widget (in full screen) shows values from the previous 13 flights: Flight time, Launch height, Launch drop, Maximum altitude. These appear in the green background box, center screen.  

On the left side there are flight maximums listed: Best flight time, Best launch height, Least launch drop. The work timer is at the bottom of this panel.  

On the right side there are flight averages: Average flight time, Average launch height, Average launch drop. The bottom 2 slots in the colume are filled with the flight mode, and the reciever voltage (assuming the reciever is being run off of pack voltage and not a BEC).  

Launch height is defined as the maximum altitude atained in the 3 seconds after leaving the last flight mode before normal flight, eg zoom.  

Launch drop is defined as the difference between the launch height and the altitue at 3 seconds after last flight mode before normal flight.  
	
