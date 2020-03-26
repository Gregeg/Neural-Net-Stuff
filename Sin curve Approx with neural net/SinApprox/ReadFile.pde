import java.util.Scanner;

ArrayList<float[][]> readFileWeights(){
  ArrayList<float[][]> out = new ArrayList<float[][]>();
  try{
    ArrayList<ArrayList<ArrayList<Float>>> temp = new ArrayList<ArrayList<ArrayList<Float>>>();
    Scanner sc = new Scanner(new File(dataPath("") + "/weights"));
    ArrayList<ArrayList<Float>> curL = new ArrayList<ArrayList<Float>>();
    curL.add(new ArrayList<Float>());
    temp.add(curL);
    curL = new ArrayList<ArrayList<Float>>();
    temp.add(curL);
    while(sc.hasNextLine()){
      String line = sc.nextLine();
      int ind = line.indexOf(",");
      if(ind == -1){
        curL = new ArrayList<ArrayList<Float>>();
        temp.add(curL);
        continue;
      }
      ArrayList<Float> curN = new ArrayList<Float>();
      curL.add(curN);
      while(ind != -1){
        curN.add(Float.parseFloat(line.substring(0, ind)));
        line = line.substring(ind+1);
        ind = line.indexOf(",");
      }
    }
    for(int i = 0; i < temp.size(); i++){
      float[][] o = new float[temp.get(i).size()][temp.get(i).get(0).size()];
      out.add(o);
      for(int j = 0; j < o.length; j++)
        for(int k = 0; k < o[0].length; k++)
          o[j][k] = temp.get(i).get(j).get(k);
    }
    sc.close();
  }catch(IOException e){
    e.printStackTrace();
  }
  return out;
}
