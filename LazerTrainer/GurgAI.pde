Long prevTime;
float learningRate = .01;
laser[] closeLazers = new laser[15];
controls GurgAI(player enemy, player me) {
  return new controls(0, -0.05, 0, false);
}
float activeFunc(float in){return (float)Math.atan(in);}
class Neuron{ 
  float val, da;
  int ind;   // index in layer
  float[] w;   // weights for previous neurons to this neuron
  Neuron(float[] w, int ind){
    this.w = w;
    this.ind = ind;
  }
  void resetValues(){val = 0; da = 0;}
  void addVal(Neuron n, int ind){val += w[ind]*n.getActVal();}
  void calcNextVal(Neuron[] next, float bias){  // bias is the same for every neuron in a layer (apparenlly its usually 1)    for first neurons, bias will be the input
    val += bias;
    for(int i = 0; i < next.length; i++)
      next[i].addVal(this, ind);
  }
  void addDA(float da){
    this.da += da;
  }
  void back(int layer, float c){
    Neuron[] prev = net.getLayer(layer-1);
    for(int i = 0; i < prev.length; i++){
      float act = prev[i].getActVal();
      float v = da/(1+w[i]*w[i]*act*act);   // g'(z) (da/dz)
      float dw = v*act;   // da/dw
      prev[i].addDA(v*w[i]);  // da(this layer)/da(lower layer)
      w[i] -= c*dw; // linearization
    }
  }
  float getActVal(){return activeFunc(val);}
  float getVal(){return val;}
}
class Network{
  ArrayList<Neuron[]> neurons = new ArrayList<Neuron[]>();
  Network(int[] nPerLayer){
    for(int i = 0; i < nPerLayer.length; i++){
      Neuron[] a = new Neuron[nPerLayer[i]];
      for(int j = 0; j < nPerLayer[i]; j++){
        float[] w;
        if(i == 0) w = new float[0];
        else {
          w = new float[nPerLayer[i-1]];
          for(int k = 0; k < w.length; k++)
            w[k] = random(-1, 1);
        }
        a[j] = new Neuron(w, j);
      }
      neurons.add(a);
    }
  }
  Network(ArrayList<float[][]> weights){    // first weights are for starting neurons, so they are ignored
    for(int i = 0; i < weights.size(); i++){
      float[][] w = weights.get(i);
      Neuron[] n = neurons.get(i);
      neurons.add(new Neuron[w.length]);
      for(int j = 0; j < w.length; j++)
        n[j] = new Neuron(w[j], j);
    }
  }
  float[] getOut(float[] in){
    for(int i = 0; i < neurons.size(); i++)
      for(int j = 0; j < neurons.get(i).length; j++)
        neurons.get(i)[j].resetValues();
    for(int i = 0; i < neurons.size()-1; i++){
      Neuron[] ns = neurons.get(i);
      for(int j = 0; j < ns.length; j++)
        ns[j].calcNextVal(neurons.get(i+1), (i==0? in[j]: 0));
    }
    Neuron[] lastNs = neurons.get(neurons.size()-1);
    float[] out = new float[lastNs.length];
    for(int i = 0; i < out.length; i++)
      out[i] = lastNs[i].getActVal();
    return out;
  }
  // cost = calculated-theoretical
  private void backProbagate(float[] cost, float c){   // for networks with an error, not the lazer trainer. making this one for fun!
    Neuron[] n = neurons.get(neurons.size()-1);
    for(int i = 0; i < cost.length; i++)
      n[i].addDA(cost[i]);
    for(int i = neurons.size()-1; i > 0; i--){
      n = neurons.get(i);
      for(int j = 0; j < n.length; j++)
        n[j].back(i, learningRate); //<>//
    }
  }
  // returns cost value (error)
  float learn(float[] in, float[] theor){
    float e = 0;
    float[] cost = getOut(in);
    for(int i = 0; i < theor.length; i++){
      cost[i] = 2*(cost[i] - theor[i]);
      e += cost[i]*cost[i]/4;
    }
    backProbagate(cost, learningRate);
    return e;
  }
  Neuron[] getLayer(int l){return neurons.get(l);}
}
