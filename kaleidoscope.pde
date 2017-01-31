import hype.*;
import hype.extended.behavior.*;
import hype.extended.colorist.*;
import hype.extended.layout.*;
import hype.interfaces.*;

HDrawablePool pool;
HColorPool colors;
HKaleidoscope kal;

void setup() {
	size(640,640, OPENGL);

	H.init(this)
    .background(#202020);

	smooth();

	HImage img0 = (HImage) H
    .add(new HImage("img.jpg"))
    .size(640)
    .loc(width / 2, height / 2)
    .anchorAt(H.CENTER);

	new HRotate(img0, 0.8);
	kal = new HKaleidoscope().sides(9);

	H.add(kal);
}

void draw() {
	H.drawStage();
}


void keyPressed() {
  if (key == 'm') 
   	kal.useMirrors(!kal.useMirrors());
  
  if (key == 'n') 
   	kal.on(!kal.on());
  
  if (key == 'a') 
  	if(kal.sides() > 2) 
   		kal.sides(kal.sides() - 1);
  
  if (key == 's') 
   		kal.sides(kal.sides() + 1);
  
  if (key == 'z') 
   		kal.rotationSpeed(kal.rotationSpeed() - 0.0001);
  
  if (key == 'x') 
   	kal.rotationSpeed(kal.rotationSpeed() + 0.0001);

}