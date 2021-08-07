//~ import processing.video.*;
//~ import processing.io.*;

//~ Capture cam;
//~ BME280 bme280;

PShader effect;
PImage img1;
PImage img2;

int num = 10;

void setup() {
  size(640, 480, P2D);
  
  //~ bme280 = new BME280("i2c-1", 0x76);

  //~ String[] devices = Capture.list();
  //~ println("Devices:");
  //~ printArray(devices);

  //~ // Use camera resolution of 640x480 pixels at 24 frames per second
  //~ cam = new Capture(this);
  //~ cam.start();

  effect = loadShader("pixelate.glsl");
  img1 = loadImage("displacement/10.jpg");
  img2 = loadImage("shinjuku.jpg");
  
  img1.resize(width,height);
  img2.resize(width,height);
  //~ cam.resize(width,height);
}

void draw() {
  background(0);
  //~ if (cam.available()) {
    //~ cam.read();
  //~ }
  
  //~ bme280.update();
  //~ float temp = bme280.temperature();
  //~ float hum = bme280.humidity();
  //~ float press = bme280.pressure();
  
  //~ float temp_r = map(temp, 25, 29, 0, 1);
  //~ println(temp_r);
  
  //~ effect.set("temp", temp_r);
  effect.set("time", millis() / 1000.0);
  effect.set("u_texture1", img1);
  effect.set("u_texture2", img2);
  image(img1, 0, 0);  
  shader(effect);
}

//~ Change displacement picture by clicking a mouse
void mouseReleased() {
  num++;
  if (num > 25)  num = 10;
  String path = "displacement/" + str(num) + ".jpg";
  img1 = loadImage(path);
  img1.resize(width,height);
}
