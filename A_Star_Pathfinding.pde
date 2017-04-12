int w, he;
int scl = 10;
float diag = (float)Math.sqrt(2);
//float diag = 1;
Point[][] points;

ArrayList<Point> open = new ArrayList<Point>();
ArrayList<Point> closed = new ArrayList<Point>();

void setup () {
  frameRate(240);
  size(700, 700);
  w = width/scl;
  he = height/scl;
  points = new Point[he][w];
  
  for (int i = 0; i < points.length; i++) {
    for (int j = 0; j < points[i].length; j++) {
      points[i][j] = new Point (i, j);
      points[i][j].heuristic();
    }
  }
  closed.add(points[0][0]);
  points[0][0].g = 0;
  points[0][0].checked = true;
  points[0][0].link();
  points[w-1][he-1].isWall = false;
}

void draw () {
  background(255);
  for (int i = 0; i < points.length; i++) {
    for (int j = 0; j < points[i].length; j++) {
      points[i][j].calcF();
      
      if (points[i][j].isWall) {
        fill(0);
        rect((i)*(scl), j*(scl), scl, scl);
      } else if (points[i][j].checked) {
        fill(153);
        rect((i)*(scl), j*(scl), scl, scl);
      } else {
        fill(255);
        rect((i)*(scl), j*(scl), scl, scl);
      }
      fill(0);
      textSize(32);
      //  text("" + points[i][j].f, (i)*scl, (j+1)*scl);
    }
  }
  
  fill(255, 0, 0);
  rect(0, 0, scl, scl);
  
  fill(0, 255, 0);
  rect((w-1)*scl, (he-1)*scl, scl, scl);
  
  if (open.size() == 0) {
    noLoop();
  }
  
  Point lowest = getMin(); //<>//
  if (lowest == null) {
    System.out.println("?");
    noLoop();
  }
  closed.add(lowest);
  open.remove(lowest);
  lowest.link();
  lowest.show();
  
  if (open.size() == 0) {
    noLoop();
    println("Not solvable");
  }
  
  for (int i = 0; i < open.size(); i++) {
    if (open.get(i) == points[he-1][w-1]) {
      open.get(i).show();
      noLoop();
    }
  }
}

Point getMin() {
  
  
  
  if (open.size() > 0) {
    Point min = open.get(0);
    for (int i = 1; i < open.size(); i++) {
      if (open.get(i).getF() < min.getF()) {
        min = open.get(i);
      }
    }
    return min;
  }
  return null;
}