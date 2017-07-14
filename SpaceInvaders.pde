boolean gameOver = false;
boolean isClicked = false;
ArrayList <Enemy> bobs = new ArrayList <Enemy>();
ArrayList <Bullet> bul = new ArrayList <Bullet>();
Player me = new Player();

public void setup()
{
  size(400, 400);
  background(0);
  for (int j = 10; j < 100; j +=30)
  {
    for (int i = 20; i < 370; i+=30)
    {
      bobs.add(new Enemy(i, j));
    }
  }
}

public void draw()
{
  background(0);
  
  for (int j = 0; j < bul.size(); j++)
  {
    for (int i = 0; i < bobs.size(); i++)
    {
      bobs.get(i).isDead(bul.get(j), me);
    }
  }
  
  for (int i = bobs.size()-1; i >= 0; i--)
  {
    if (bobs.get(i).getIsDead())
      bobs.remove(i);
  }
  
  for (int i = bul.size()-1; i >= 0; i--)
  {
    if (bul.get(i).getCrashed())
      bul.remove(i);
  }
  
  for (int i = 0; i < bobs.size(); i++)
  {
    bobs.get(i).move();
    bobs.get(i).show();
  }
  me.move();
  me.show();
  
  for (int i = 0; i < bul.size(); i++)
  {
    bul.get(i).move();
    bul.get(i).show();
  }
  fill(255);
  textSize(15);
  text("Score: " + me.getScore(), 10, 15);
  
  if (bobs.size() == 0)
  {
    textSize(50);
    text("You Win!! :)", 50, 190);
  }

}

public void mouseClicked()
{
  bul.add(new Bullet(me));
}

class Enemy
{
  double myX, myY;
  int mySize;
  int pointsGiven, healthTaken, timesHit;
  boolean isDead;
  public Enemy(int x, int y)
  {
    myX = x;
    myY = y;
    mySize = 20;
    pointsGiven = 10;
    healthTaken = 10;
    timesHit = 0;
    isDead = false;
  }
  public void move()
  {
    setY(myY + 0.05);
  }
  public void show()
  {
    fill(0, 200, 0);
    rect((int)getX(), (int)getY(), mySize, mySize);
  }
  public boolean isDead(Bullet bu, Player x)
  {
    if ( (int)getY() <= bu.getY()
        && (int)getY()+20 >= bu.getY()
        && bu.getX() >= (int)getX()
        && bu.getX() <= (int)getX()+ mySize)
    {
      setIsDead(true);
      bu.setCrashed(true);
      x.setScore(x.getScore() + getPointsGiven());
      return true;
    }
    return false;
  }
  public double getX() { return myX; }
  public double getY() { return myY; }
  public void setY(double num) { myY = num; }
  public int getSize() { return mySize; }
  public void setSize(int newSize) { mySize = newSize; }
  public boolean getIsDead() { return isDead; }
  public void setIsDead(boolean dead) { isDead = dead; }
  public int getPointsGiven() { return pointsGiven; }
}


class Player
{
  int myX, myY;
  int score, health;
  public Player()
  {
    myX = mouseX - 20;
    myY = 375;
    score = 0;
    health = 100;
  }
  public void move()
  {
    setX(mouseX-20);
  }
  public void show()
  {
    fill(255, 0, 255);
    rect(getX(), 360, 40, 80, 5);
  }
   public int getX() { return myX; }
   public void setX(int x) { myX = x; }
   public int getY() { return myY; }
   public int getScore() { return score; }
   public void setScore(int sc) { score = sc; }
}


class Bullet
{
  int myX, myY, damage, bulletSize;
  boolean isCrashed;
  public Bullet(Player play)
  {
    myX = play.getX() + 20;
    myY = play.getY() - 20;
    damage = 10;
    bulletSize = 10;
    isCrashed = false;
  }
  public void move()
  {
    setY(getY()-10);
  }
  public void show()
  {
    fill(255);
    noStroke();
    ellipse(getX(), getY(), bulletSize, bulletSize);
  }
  
  public int getX() { return myX; }
  public int getY() { return myY; }
  public boolean getCrashed() { return isCrashed; }
  public void setX(int x) { myX = x; }
  public void setY(int y) { myY = y; }
  public void setCrashed(boolean c) { isCrashed = c; }
}
