player yit,gurg;
ArrayList<laser> lasers = new ArrayList();
Network net;
void setup() {
  size(600,600);
  yit = new player(100,100,color(0,255,0),0);
  gurg = new player(500,500,color(255,0,255),0);
  frameRate(144);
  int[] layers = {1, 5, 5, 5, 1};
  net = new Network(layers);
}

void draw() {
    background(0);
    gurg.update(GurgAI(yit.copy(),gurg.copy()));
    for (int i = lasers.size() -1; i >=0; i--) {
      lasers.get(i).update();
    }
    randomLaser();
}

void randomLaser(){
  float p = random(0, width+height), r = random(0, PI*2);
  lasers.add(new laser((p > width? new PVector(p, width): new PVector(width, p-width)), r));
}
