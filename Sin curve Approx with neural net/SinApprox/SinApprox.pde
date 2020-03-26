Network net;
void setup() {
  size(600,600);
  int[] layers = {1, 20, 30, 30, 20, 1};
  net = new Network(layers);
  
}

void draw() {
    clear();
    for(int i = 0; i < 1000; i++){
      float v = (float)(Math.random()*PI-PI/2);
      float[] t = {v}, out = {(float)Math.sin(v)};
      net.learn(t, out);
    }
    strokeWeight(2);
    for(double d = -PI/2; d < PI/2; d+=.001){
      float[] in = {(float)d};
      float x = (float)d*100+300;
      float y = net.getOut(in)[0]*200 + 300;
      stroke(255, 0, 0);
      point(x, (float)Math.sin(d)*200 + 300);
      stroke(0, 0, 255);
      point(x, y);
    }
}
