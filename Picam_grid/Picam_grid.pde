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
  
  //bme280.update();
  //float temp = bme280.temperature();
  //float hum = bme280.humidity();
  //float press = bme280.pressure();
  
  //float size = map(temp, 25, 35, 0, 1) * 100;
  
  effect.set("pixels", 0.15*mouseX, 0.15*mouseY);
  //effect.set("pixels", size, size);
  println(mouseX);
  image(cam, 0, 0);  
  shader(effect);
}

void keyPressed() {
	if (key == 'S' || key == 's') {
		save("save/pic.jpg");
	}
}
