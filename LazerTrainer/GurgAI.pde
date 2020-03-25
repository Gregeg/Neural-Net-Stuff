Long prevTime;
controls GurgAI(player enemy, player me) {
  if(prevTime == null) prevTime = System.currentTimeMillis();
  long cur = System.currentTimeMillis();
  float t = (((float)(cur-prevTime))/100)%(2*PI) + PI/6;
  return new controls((float)Math.cos(-t)/5, (float)Math.sin(-t)/5, t + PI, !enemy.dead);
  
}
