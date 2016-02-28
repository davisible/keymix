import ddf.minim.Minim;
import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

void setup() {
  size(500, 120); 
  minim = new Minim(this);
  player = minim.loadFile("test3.mp3");
  fft = new FFT(player.bufferSize(), player.sampleRate());
  player.play();
}

void draw() {
  background(0);
  stroke(255);
  for(int i = 0; i < player.bufferSize() - 1; i++)
  {
    float left1 = 50 + player.left.get(i) * 50;
    float left2 = 50 + player.left.get(i+1) * 50;
    float right1 = 60 + player.right.get(i) * 50;
    float right2 = 60 + player.right.get(i+1) * 50;
    line(i, left1, i+1, left2);
    line(i, right1, i+1, right2);
  }

  fft.forward(player.mix);
  noStroke();
  fill(255, 0, 0, 128);
  for(int i = 0; i < 250; i++) {
    float b = fft.getBand(i);
    rect(i*2, height - b, 5, b);
}
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}