Long prevTime;
laser[] closeLazers = new laser[15];
controls GurgAI(player enemy, player me) {
  return new controls(0, -0.05, 0, false);
}

class Neuron{ 
  float val;
  int ind;   // index in layer
  float[] w;   // weights for previous neurons to this neuron\
  Neuron(float[] w, int ind){
    this.w = w;
    this.ind = ind;
  }
  float activeFunc(float in){return (float)Math.atan(in);}
  void resetVal(){val = 0;}
  void addVal(float val, int ind){this.val += w[ind]*activeFunc(val);}
  void calcNextVal(Neuron[] next, float bias){  // bias is the same for every neuron in a layer (apparenlly its usually 1)    for first neurons, bias will be the input
    val += bias;
    for(int i = 0; i < next.length; i++)
      next[i].addVal(val, ind);
  }
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
  float[] getOut(float[] in){
    for(int i = 0; i < neurons.size()-1; i++){
      Neuron[] ns = neurons.get(i);
      for(int j = 0; j < ns.length; j++)
        ns[j].calcNextVal(neurons.get(i+1), (i==0? in[j]: 1));
    }
    Neuron[] lastNs = neurons.get(neurons.size()-1);
    float[] out = new float[lastNs.length];
    for(int i = 0; i < out.length; i++)
      out[i] = lastNs[i].getVal();
    return out;
  }
}
