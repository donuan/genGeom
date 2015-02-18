# genGeom
Interactive installation based on generative l-system


.genGeom
// A generative installation
// by Hannes Andersson Donuan (donuanTv)
// 2015
genGeom() {
is a sci-fi inspired visual installation exploring code based
geometry and simulated natural shapes generated in real time
from user interaction.
}

howItWorks() {
Fractal shapes or polygons are generated from algorithms
such as l-systems (also known as lindenmayer systems).
The user is given control over the variables of the
algorithms through the genGeom interface, Which is accessed
through an android phone or tablet
(such as Samsung Galaxy or Nexus 7).
The result is an ever-changing geometrical shape which is
projected in large scale upon a suitable surface.
}
theInterface() {
is an android app made in Processing that the users interact
with through touch.
}
technicalSetup() {
The user interaction data is sent from the genGeom android
app to the shape generating genGeom Processing sketch (running
on a computer) as OSC (open sound control) messages via Wi-Fi.
The genGeom sketch interprets the OSC messages as variables in
the algorithms generating the geometrical shapes.
The generated shapes are sent to a projector, which projects
the end result; a generated projected shape that can be
manipulated in real time.
}
> >
aboutTheArtist() {
Hannes Andersson (Donuan) is a researcher, Filmmaker,
Digital Artist and Audio-Visual Performer.
His work focuses on perception and visual communication in
the in-between of art and science.
http://donuan.tv
Short Bio(){
Hannes is originally from Gothenburg (Sweden), currently
based in the UK. He studied Digital Film & Animation at
SAE Institute Barcelona (Catalonia).
He is co-founder of the digital art collective “Chinos
International CC”, developing interactive art and open
source technology, materialised i.e. in audio-visual and
physical installations exploring concepts of user affectability
by applying techniques for spatial placement, tracking of user
position and body movement.
He is co-founder and director of “Andersson Rodriguez Films”,
an independent film production company, mainly producing
narrative cinema shorts and digital videos for distribution on
web.
In 2014 he was selected to represent Bologna for the European
Union Culture Project “Performigrations, People are the
Territory”, for which he develops an audio-visual installation
to be presented in seven cities in Europe and in Canada during
2015.
}
}

#Instructions

the andoid app is controlling an l-system running on a computer.
you will need to run the desktop part in processing (or export it from there).
the desktop sketch is made in Proccesing 2.2.1 (java)
the app is made in Proccesing 2.2.1 (andoid), but will function in java if you comment:
import android.content.Context;                
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;

genGeomOscAcc is the code for the app itself and genGeomDesktop is the receiver (running on the computer).
if you do not want to change the functionality of the app you can download it as an .apk here: http://donuan.tv/project_gengeom.htm

the app is sending OSC messages to the IP specified in the pde sketch (currently 192.168.1.102) so you need to set the computer IP to this for the communication to function (or change the ip in the app sketch and upload the updated version to the mobile device, for this you will need android SDK installed). once that is done the communication should work fine as long as both the phone/tablet and the computer is connected to the same WiFi.

the desktop sketch is sending out the frames to syphon so that you could receive them in Mad Mapper / Modul8 / quartz composer / etc.
if you are running the sketch on a PC you will need to comment that functionality out as the syphon framework is mac only (then just comment out everything that says "syphon").

the sketch is using the libraries: oscP5, syphon, peasycam, toxiclibs (you can grab them from the libraries folder)

#The App is sending:
mouseX, mouseY, the value of the slider, if the app is in "triangle mode" or "circle mode", the accelerometor X, Y, Z)

mouseX and mouseY which are received as the 1st and 2nd OSC value: remoteMouseX (int)
remoteMouseY (int)

the 3rd value is the position of the slider in the left corner of the app. this value is received as sliderValue (float).
this is set to control the zoom in/out.
(there is also a commented series of ifs concerning the sliderValue. this can be uncommented to have the slider controll the number of generations in the l-system).

the 4th OSC message is a true / false messages stating if the app is in circle mode or triangle mode which is changed in the bottom right corner of the app.
this is set to change the apperance of the l-system.

the 5th value is a true / false message stating if the text in the app is pressed or not.
this is set to control rotation.

6th, 7th and 8th OSC message are corresponding to the android device's accelerometor (X,Y,Z)

they are commented out because they are currently not set to affect anything but the app is sending them so they could be used for something without altering the app.

hope you like it. let me know if you make it do something else :)


