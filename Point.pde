public class Point {
  public int x;
  public int y;
  public boolean checked = false;
  public boolean isWall;
  
  
  public double g;
  public double h;
  public double f;
  
  private Point parent = null;
  
  public void link() {
    for (int i = x-1; i < x+2; i++) {
      for (int j = y-1; j < y+2; j++) {
        if ((i >= 0 && j >= 0) && (j < he && i < w)) {
          //System.out.println(i +" " + j);
          boolean closer = false;
          for (int c = 0; c < closed.size(); c++) {
            if (points[i][j] == closed.get(c)) {
              closer = true;
            }
          }
          if (!closer && !points[i][j].isWall) {
            boolean opener = false;
            for (int b = 0; b < open.size(); b++) {
              if (points[i][j] == open.get(b)) {
                //println("ok");
                opener = true;
              }
            }
            if (opener) {
              if (g < points[i][j].g-1 && (i == x || j == y)) {
                points[i][j].g = g+1;
                points[i][j].setParent(points[x][y]);
                points[i][j].calcF();
                
              } else if (g < points[i][j].g-diag) {
                points[i][j].g = g+diag;
                points[i][j].setParent(points[x][y]);
                points[i][j].calcF();
              }
            } else {
              open.add(points[i][j]);
              points[i][j].checked = true;
              if (i != x && j != y) {
                points[i][j].g = g + diag;
              } else {
                points[i][j].g = g+1;
              }
              points[i][j].setParent(points[x][y]);
              points[i][j].calcF();
            }
          }
        }
      }
    }
  }
  
  public void setParent(Point p) {
    parent = p;
  }
  
  public Point (int xcord, int ycord) {
    x = xcord;
    y = ycord;
    float chance = random(3);
    if (chance < 1) {
      isWall = true;
    } else {
      isWall = false;
    }
  }
  
  public void heuristic () {
    h = Math.sqrt(Math.pow((w-x), 2) + Math.pow((he-y), 2));
  }
  
  public void calcF() {
    f = g+h;
  }
  
  public double getF() {
    return f;
  }
  
  public void show() {
    if (parent!=null) {
      stroke(0);
      line(x*scl+scl/2, y*scl+scl/2, parent.x*scl+scl/2, parent.y*scl+scl/2);
      parent.show();
    }
  }
}