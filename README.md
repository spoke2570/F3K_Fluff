# F3K_Fluff
Sport flyer widget for FrSky ETHOS
![image](https://github.com/user-attachments/assets/a675d41b-7c95-4f4e-acc6-21a6705cfb25)

Thanks for looking at my F3K sport flyer widget. This guy was made to work with my own planes and I hope can be useful Ito others. Sorry Only in english with Si units, so meters and seconds are primary. Feel free to lift any part of this for whatever use.

To use this widget, download and expand the .zip file in this repository and place the resulting folder "F3KFluff" in your radio's "Scripts" folder. Use the configure screens menue to get a full screen or full window widget screen. Use the configure widget menu to select the "F3K_Fluff" from the lest of available widgets, and configure the widget.      
*** NOTE: The naming convention for this widget is important to its operation, so please do not rename the folder that contains this widget.

The widget wll make a folder inside the folder "F3KFluff" named "Session Data" that will contain unique session data for each model the script is used on. It is fairly readable with a text editor, and will rewrite itself each time the radio is shut off or the model is switched. 

Features of this widget are:

1) Current flight information on the top row (resets with a new launch)
2) Flight session maximums in the left panel
3) Flight session averages in the rigth panel with number of flights recorded
4) Last 10 or 13 flights information in the center panel
5) Displays reciver voltage when connected and transmitter voltage when not.
6) Can be used on mutiple models in the same radio. 
7) Ability to shut down radio and rejoin the previous session on restart (yep I gotta answer nature's call, too).      
   *** NOTE: This feature is unregulated at this point and is only intended for a daily session. Use for too many launches could overwhelm your system memory. So far I have run it at more than 60 flights with no problems. ***
      
I have tested this to be pretty robust even when a new model with no flight modes or timers or telemetry is chosen. (Of course you would not want that sort of set up).

This widget assumes that you have your model set up to have "launch" and "zoom" flight modes (defined below), a flight timer, and an altitude sensor that will keep maximum altitudes. Mine are all FrSky reciever based. 

To work this needs from you (or it won't work):

1) Flight timer source
2) Altitude source
3) Launch mode (mode that says you are going to throw the plane)
4) Zoom mode (last mode before regular flight). I assume this one ends as the model is being nosed over into level flight.      
   *** NOTE: Launch and zoom can be the same mode, but if they are different it is best ot set thins up like that. *** 
  
Choices you will find in the congfigure screen:  

1) Flight timer source -> I am assuming here that you have a flight timer you like, so I want to provide information from it. This must exist.
2) Work timer source -> Maybe you have one you like. Maybe you want it to be a sum of your flight times. Maybe you want mine that runs when the reciever is connected.
3) Launch mode source -> Mode that says you ar going to throw the plane. This must exist.
4) Zoom mode source -> Last mode before regular flight. This must exist but can be same and launch mode.
5) Altidude sensor -> Defaults to whatever FrSky sensor is named "altitude". This must exist.
6) Minimum altitude for good launch ->  This is the altiude when coming out of zoom. If it is too low the flight will not be recorded in the widget.
7) Play minutes -> This allows you to silence the calling of the whole minutes of your flight. It is arranged so that it will not play the seconds, only the minute increments of the flinght, eg. "1 min".."2 min"...  
 
The widget was built for an X20S "full screen" window, or largest window (with the system header and footer). The simulators show that it will work for all of the radios that support ETHOS. I imagine the the smaller screened radios will make the text difficult to read.  
 
The widget reports current flight conditions in the top row (largest font): Flight time,  Launch height, Launch drop, Current altitude, Maximum altitude.  

The widget (in full screen) shows values from the previous 13 flights: Flight time, Launch height, Launch drop, Maximum altitude. These appear in the green background box, center screen.  

On the left side there are flight maximums listed: Best flight time, Best launch height, Least launch drop. The work timer is at the bottom of this panel.  

On the right side there are flight averages: Average flight time, Average launch height, Average launch drop. The bottom 2 slots in the colume are filled with the flight mode, and the reciever voltage (assuming the reciever is being run off of pack voltage and not a BEC).  

Launch height is defined as the maximum altitude atained in the 3 seconds after leaving the last flight mode before normal flight, eg zoom.  

Launch drop is defined as the difference between the launch height and the altitue at 3 seconds after last flight mode before normal flight.  
	
