 ArrayList<Explosion> explosion;
    ArrayList<Rocket> rocket;
    ArrayList<City> city;

    void setup(){
     size(screen.width, screen.height);
     explosion = new ArrayList<Explosion>();
     rocket = new ArrayList<Rocket>();
     city = new ArrayList<City>();

     smooth();
    }

    void draw(){
     fill(0, 0, 0, 10);          //a transparent rectangle instead of a background can create a trail for the rocket
     rect(0,0,width,height);
     launch();
     setRocket();
     explode();

    }


    void setRocket(){     
      if(mousePressed){
        rocket.add(new Rocket()); 
      }
    }

    void launch(){        //launch rockets then let them explode
      for(int r = 0; r < rocket.size(); r++){
        Rocket roc = rocket.get(r);
        roc.draw();
        if(roc.reached()){
          explosion.add(new Explosion(roc.getX(),roc.getY(),roc.getColor()));
          rocket.remove(r);
        }
      }
    }

    void explode(){    //explode once rocket reaches its height, then disappear after a short while
      for(int e = 0; e < explosion.size(); e++){
        Explosion ex = explosion.get(e);
        ex.draw();
        if(ex.over()){
          explosion.remove(e);
        }
      }
      
    }

    class Explosion{        //Explosion phase of fireworks
      
      ArrayList<Particles> particle;
      float x,y,xa,ya,dis,fin;
      color col;
      
      Explosion(float xx, float yy, color c){
        particle = new ArrayList<Particles>();
        x = xx;
        y = yy;
        col = c;
        dis = 0;
        fin = random(75,150);
      }
      
      void draw(){

        for(int a = 0; a < 360; a += 12){
          xa = sin(radians(a))*dis;
          ya = cos(radians(a))*dis;      
          particle.add(new Particles(x+xa,y+ya,col));      
        } 
        for(int p = 0; p < particle.size(); p ++){
          Particles part = particle.get(p);
          part.draw();
          particle.remove(p);
        }
        dis++;
      }
      
      boolean over(){
        return dis > fin;
      }
      
    }
    class Particles{       //Partilces from the explosion
      
     float x,y,dia,dis;
     color c;
     
     Particles(float xx, float yy, color col){
      x = xx;
      y = yy;
      dia = 2;
      c = col;
      dis = 20;
     } 
     
     void draw(){
       noStroke();
       fill(c);
       ellipse(x,y,dia,dia);
     }
     
     float getDist(){
       return dis;
     }
     
    }
    class Rocket{     //the launch sequence
      
      color c;
      float dia, x,y,beginx, beginy, endy, r, g, b;
      
     Rocket(){
      dia = 5;
      x = random(width);
      y = height;
      endy = random(50,500);
      r = random(120,250);
      g = random(120,250);
      b = random(120,250);
      c = color(r);
     } 
      
      void draw(){
       noStroke();
       fill(c); 
       ellipse(x,y,dia,dia);
       y -= 5;
      }
      
      float getX(){
       return x;
      }
      float getY(){
       return  y;
      }
      float getEnd(){
       return endy; 
      }
      color getColor(){
       return c; 
      }
      boolean reached(){
       return y < endy;
      }
      
    }