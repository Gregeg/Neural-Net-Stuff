class laser {
  PVector pos;
  float rot;
  int life = 150;
  laser(PVector pos, float rot) {
    this.pos = new PVector(pos.x,pos.y);
    this.rot = rot;
  }
  
  void update() {
    if (life < 1) {
      lasers.remove(this);
    }
    life--;
    pos = pos.add(new PVector(5,0).rotate(rot));
    pos = new PVector((pos.x+width)%width,(pos.y+height)%height);
    stroke(255,0,0);
    line(pos.x,pos.y,pos.x+10*cos(rot),pos.y+10*sin(rot));
  }
}
