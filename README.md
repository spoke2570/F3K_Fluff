# F3_Fluff (This works pretty good with winch, bungee and arm toss)
# Now altitude units follow those given by the chosen sensor
Sport flyer F3K/DLG widget for FrSky ETHOS
	![screenshot-2025-07-14-48964](https://github.com/user-attachments/assets/6c954d68-6ee2-4b90-9307-f03bf056cd9a)


Thanks for looking at my F3K sport flyer widget. This guy was made to work with my own planes and I hope can be useful to others. Sorry Only in english. Feel free to lift any part of this for whatever use. 

Motivation for this was a  widget that was dedicated to just plane flying and used the timers and voice calls that I have configured my F3K model template to use independant from the widget environment. Many thanks to Static for the layout idea, strgaltdel for help understanding the ETHOS environment, Bertrand's widget template for keeping me from getting lost, mikeshellim, LotharThole and every one else over at RCG who helps to make this knowledge accessible to amatures like me. 

To use this widget, download and expand the F3KFluff.zip file from the release that coresponds with your version of ETHOS in the releases section of this repository and place the resulting folder "F3KFluff" in your radio's "Scripts" folder. Use the configure screens menue to get a full screen or full window widget screen. Use the configure widget menu to select the "F3K Fluff MB" from the list of available widgets, and configure the widget.      
*** NOTE: The naming convention of this widget is important to its operation, so please do not rename the folder that contains this widget.

The widget wll make a folder inside the "F3KFluff" directory named "Session Data" that will contain unique session data for each model the script is used on. It is fairly readable with a text editor, and will rewrite itself each time the radio is shut off or the model is switched. 

Features of this widget are:

1) Current flight information on the top row (resets with a new launch)
2) Flight session maximums in the left panel
3) Flight session averages in the rigth panel with number of flights recorded
4) Last 10 or 13 flights information in the center panel (full screen and largest window respectivly)
5) Displays reciver voltage when connected and transmitter voltage when not.
6) Can be used on mutiple models in the same radio. 
7) Ability to shut down radio and rejoin the previous session on restart (yep I gotta answer nature's call, too).      
   *** NOTE: This feature is unregulated at this point and is only intended for a daily session. Use for too many launches could overwhelm your system memory. So far I have run it at more than 60 flights with no problems. 
      
I have tested this to be pretty robust even when a new model with no flight modes or timers or telemetry is chosen. (Of course you would not want that sort of set up).

This widget assumes that you have your model set up to have "launch" and "zoom" flight modes (defined below), a flight timer, and an altitude sensor that will keep maximum altitudes. Mine are all FrSky reciever based. 

To work this needs from you (or it won't work):

1) Flight timer source
2) Altitude source
3) Launch mode (mode that says you are going to throw the plane)
4) Zoom mode (last mode before regular flight). I assume this one ends as the model is being nosed over into level flight.      
   *** NOTE: Launch and zoom can be the same mode, but if they are different it is best ot set things up like that.      
   *** NOTE: This widget is based around meters for measurment of length, so your radio needs to be set for SI units, not imperial.

The widget was built for an X20S "full screen" window, or largest window (with the system header and footer). The simulators show that it will work for all of the radios that support ETHOS. I imagine the the smaller screened radios will make the text difficult to read.  

![screenshot-2025-07-20-41822](https://github.com/user-attachments/assets/6b90cd80-abf2-4931-8e38-d0341a61b32b)


   Choices you will find in the congfigure screen: 

![screenshot-2025-07-20-41995](https://github.com/user-attachments/assets/80c1a770-d5ad-4262-8e75-ae68a4e6767b) 

1) Flight timer source -> I am assuming here that you have a flight timer you like, so I want to provide information from it. This must exist.
2) Work timer source -> Maybe you have one you like. Maybe you want it to be a sum of your flight times. Maybe you want mine that runs when the reciever is connected.
3) Launch mode source -> Mode that says you ar going to throw the plane. This must exist.
4) Zoom mode source -> Last mode before regular flight. This must exist but can be same as launch mode.
5) Altidude sensor -> Defaults to whatever FrSky sensor is named "altitude". This must exist.
6) Minimum altitude for good launch ->  This is the altiude when coming out of zoom. If it is too low the flight will not be recorded in the widget.
7) Play minutes -> This allows you to silence the calling of the whole minutes of your flight. It is arranged so that it will not play the seconds, only the minute increments of the flinght, eg. "1 min".."2 min"...  
 
The widget reports current flight conditions in the top row (largest font): Flight time,  Launch height, Launch drop, Current altitude, Maximum altitude.  
![Untitled](https://github.com/user-attachments/assets/3bc73427-8cef-4f94-b660-bda24cb399a6)      
Launch height is defined as the maximum altitude atained in the 3 seconds after leaving the last flight mode before normal flight, eg zoom.  

Launch drop is defined as the difference between the launch height and the altitue at 3 seconds after last flight mode before normal flight.      

The widget (in full screen) shows values from the previous 13 flights: Flight time, Launch height, Launch drop, Maximum altitude. These appear in the green background box, center screen.  
![Untitled](https://github.com/user-attachments/assets/a0833685-d90b-495a-b8ce-319946c1928a)  
When the model is changed or the radio is shut down it will write the session data that is displayed on the screen to a file that is unique to the model in use.  

On the left side there are flight maximums listed: Best flight time, Best launch height, Least launch drop. The work timer is at the bottom of this panel.  
![11](https://github.com/user-attachments/assets/0c157ed9-a857-4056-9f18-ffd21d84a3db)      


On the right side there are flight averages: Average flight time, Average launch height, Average launch drop. The bottom 2 slots in the colume are filled with the number of recorded flights, and the reciever voltage (assuming the reciever is being run off of pack voltage and not a BEC), or the Tx voltage oif the reciever is not connected. .  
![234](https://github.com/user-attachments/assets/1bdd947e-a2a7-417f-b473-64e7fd5e8792)

The system menu is used for interaction with the widget. When the model is loaded no stored data is displayed. The default is to start a new flying session.
The system menu will show appropriate options when called to view by taping the screen twice or the enter key twice.      
![324](https://github.com/user-attachments/assets/d249f247-e837-494d-aa6d-b88a253d31c3)  ![53424](https://github.com/user-attachments/assets/adbcabde-fed1-4719-ad9a-2f10e9913caa)

"Continue last session" is available when there is no data visible in the screen and there is a file containing previous data for the model.      
"Continue this session" is available when there is data loaded and visible on the screen, or there is no file containing prevoius data for the model.      
"Start new session" dumps any flight data currently visible on the screen and starts a fresh session. 

	
