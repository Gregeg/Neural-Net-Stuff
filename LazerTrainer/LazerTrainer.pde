player yit,gurg;
ArrayList<laser> lasers = new ArrayList();
Network net;
void setup() {
  size(600,600);
  yit = new player(100,100,color(0,255,0),0);
  gurg = new player(500,500,color(255,0,255),0);
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
    //background(0);
    //gurg.update(GurgAI(yit.copy(),gurg.copy()));
    //for (int i = lasers.size() -1; i >=0; i--) {
    //  lasers.get(i).update();
    //}
    //randomLaser();
}

void randomLaser(){
  float p = random(0, width+height), r = random(0, PI*2);
  lasers.add(new laser((p > width? new PVector(p, width): new PVector(width, p-width)), r));
}
