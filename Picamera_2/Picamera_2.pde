import processing.video.*;
import processing.io.*;

Capture cam;
BME280 bme280;

PShader effect;

void setup() {
  size(640, 480, P2D);
  
  bme280 = new BME280("i2c-1", 0x76);

  String[] devices = Capture.list();
  println("Devices:");
  printArray(devices);

  // Use camera resolution of 640x480 pixels at 24 frames per second
  cam = new Capture(this);
  cam.start();

  effect = loadShader("pixelate.glsl");
}

void draw() {
  background(0);
  if (cam.available()) {
    cam.read();
  }
  
  bme280.update();
  float temp = bme280.temperature();
  float hum = bme280.humidity();
  float press = bme280.pressure();
  
  float temp_r = map(temp, 25, 35, 0, 1);
  
  effect.set("temp", temp_r);
  effect.set("time", millis() / 1000.0);
  //println(mouseX);
  image(cam, 0, 0);  
  shader(effect);
}
