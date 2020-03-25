class player {
  PVector pos, spd;
  float rot;
  color c;
  boolean dead = false;
  player(float x, float y, color c, float r) {
    pos = new PVector(x, y);
    spd = new PVector(0, 0);
    this.c = c;
    rot = r;
  }
  player(float x, float y, color c, float r, boolean dead){
    pos = new PVector(x, y);
    spd = new PVector(0, 0);
    this.c = c;
    rot = r;
    this.dead = dead;
  }
  void update(controls control) {
    if (!dead) {
      pos = pos.add(spd);
      spd = spd.add(new PVector(control.x, control.y));
      //if (spd.mag() > 100) {
      //  dead = true;
      //}
      for (int i = 0; i < lasers.size(); i++) {
        if (pow(lasers.get(i).pos.x-pos.x, 2)+pow(lasers.get(i).pos.y-pos.y, 2)<10) {
          dead=true;
        }
      }
      rot = control.r;
      pos = new PVector((pos.x+width)%width, (pos.y+height)%height);
      show();
      if (control.s) {
        lasers.add(new laser(pos, rot));
      }
    }
  }

  void show() {
    fill(0, 0);
    stroke(c);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rot);
    triangle(-5, 5, -5, -5, 10, 0);
    popMatrix();
  }
  
  player copy() {
    return new player(pos.x,pos.y,c,rot,dead);
  }
}

class controls {
  float x, y, r;
  boolean s;
  controls(float x, float y, float r, boolean s) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.s = s;
  }
}
