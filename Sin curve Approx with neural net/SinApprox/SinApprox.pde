import java.util.function.Function;
Network net;
boolean readFile = false;
ArrayList<float[][]> w;
float func(float n){return (float)Math.sin(n);} //  change function here
void setup() {
  size(600,600);
  if(readFile && new File(dataPath("") + "/weights").exists())
    net = new Network(readFileWeights());
  else{
    int[] layers = {1, 5, 10, 10, 5, 1};   // change layers here
    net = new Network(layers);
  }
  w = net.getWeights();
}

void draw() {
    clear();
    for(int i = 0; i < 1000; i++){
      float v = (float)(Math.random()*PI-PI/2);
      float[] t = {v}, out = {func((float)v)};
      net.learn(t, out);
    }
    for(int i = 0; i < w.size(); i++){
      for(int j = 0; j < w.get(i).length; j++){
        for(int k = 0; k < w.get(i)[j].length; k++)
          print(w.get(i)[j][k] + ",");
        println();
      }
      println();
    }
    println("\n\n");
    strokeWeight(2);
    for(double d = -PI/2; d < PI/2; d+=.001){
      float[] in = {(float)d};
      float x = (float)d*100+300;
      float y = net.getOut(in)[0]*200 + 300;
      stroke(255, 0, 0);
      point(x, func((float)d)*200 + 300);
      stroke(0, 0, 255);
      point(x, y);
    }
}
