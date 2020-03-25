controls YitAI(player enemy, player me) {
  return new controls(.005, 0, atan2(enemy.pos.y-me.pos.y,enemy.pos.x-me.pos.x), true);
}
