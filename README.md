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
