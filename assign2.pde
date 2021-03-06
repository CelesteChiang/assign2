/* please implement your assign1 code in this file. */

PImage healthPoint , treasure , outerSpace1 , outerSpace2 , enemy , fighter , start1 , start2 , end1 , end2 ;
int xOuterSpace , hpAmount , xEnemy , yEnemy , enemySpeed , xTreasure , yTreasure , xFighter , yFighter ;

final int GAME_START=1 , GAME_RUN=2 , GAME_LOSE=3 ;
int gameState ;
final int fullHp = 205 ;

boolean upPressed = false , downPressed = false , leftPressed = false , rightPressed = false ;

void setup () {
  size(640,480) ; 
  
  outerSpace1 = loadImage("img/bg1.png") ;
  outerSpace2 = loadImage("img/bg2.png") ;
  xOuterSpace = 0 ;
  
  healthPoint = loadImage("img/hp.png") ;
  hpAmount = fullHp/5 ;
  
  treasure = loadImage("img/treasure.png") ;
  xTreasure = floor(random(100,600)) ;
  yTreasure = floor(random(100,400)) ;
  
  enemy = loadImage("img/enemy.png") ; 
  xEnemy = -enemy.width ;
  yEnemy = floor(random(80,400)) ;
  enemySpeed = floor(random(7,10)) ;
  
  fighter = loadImage("img/fighter.png") ;
  xFighter = 550 ; 
  yFighter = 300 ;

  start1 = loadImage("img/start1.png") ;
  start2 = loadImage("img/start2.png") ;
  end1 = loadImage("img/end1.png") ;
  end2 = loadImage("img/end2.png") ;
  
  gameState = GAME_START ; 
  
}

void draw() {
  
  switch (gameState){
    
    case GAME_START:   
    if ( 190 < mouseX && mouseX < 450 && 370 < mouseY && mouseY < 410) {
      image(start1,0,0) ; 
      if(mousePressed){
        gameState = GAME_RUN ;
        }
      }else{
      image(start2,0,0) ;
    }       
      break ;   
    
    case GAME_RUN :
    
    if(upPressed){ yFighter -= 15 ; }
    if(downPressed){ yFighter += 15 ; }
    if(leftPressed){ xFighter -= 15 ; }
    if(rightPressed){ xFighter += 15 ; }
    //boundary detection
    if (xFighter > 640-fighter.width/2 ) { xFighter = 640-fighter.width/2 ; }
    if (xFighter < fighter.width/2 ) { xFighter = fighter.width/2 ; }
    if (yFighter > 480-fighter.height/2 ) { yFighter = 480-fighter.height/2 ; }
    if (yFighter < fighter.height/2 ) { yFighter = fighter.height/2 ; }
        
    //outer space  
    image(outerSpace2,xOuterSpace,0) ;
    image(outerSpace1,xOuterSpace-outerSpace2.width,0) ;
    image(outerSpace2,xOuterSpace-outerSpace2.width-outerSpace1.width,0) ;
    xOuterSpace++ ;
    xOuterSpace %= (outerSpace2.width+outerSpace1.width) ;
  
    //health point
    fill(255,0,0);
    rect(45, 10, hpAmount, 30, 25) ;
    image(healthPoint,40,10) ;  

    //treasure
    image(treasure, xTreasure, yTreasure) ;
    if ( xTreasure-treasure.width/2-fighter.width/2 < xFighter && xFighter < xTreasure+treasure.width/2+fighter.width/2
    && yTreasure-treasure.height/2-fighter.height/2 < yFighter && yFighter < yTreasure+treasure.height/2+fighter.height/2
    && hpAmount < fullHp-fullHp/10 ) {
        hpAmount = hpAmount+fullHp/10 ;
        xTreasure = floor(random(100,600)) ;
        yTreasure = floor(random(100,400)) ;
    }else if( xTreasure-treasure.width/2-fighter.width/2 < xFighter && xFighter < xTreasure+treasure.width/2+fighter.width/2
    && yTreasure-treasure.height/2-fighter.height/2 < yFighter && yFighter < yTreasure+treasure.height/2+fighter.height/2
    && hpAmount >= fullHp-fullHp/10) {
      hpAmount = fullHp;
      xTreasure = floor(random(100,600)) ;
      yTreasure = floor(random(100,400)) ;  
  }
  
    //fighter
    image(fighter,xFighter,yFighter);
  
    //enemy
    image(enemy,xEnemy,yEnemy) ;
    xEnemy += enemySpeed ;
    xEnemy %= 640 ;
    yEnemy = yEnemy-(yEnemy-yFighter)/12 ;
    if ( xEnemy-enemy.width/2-fighter.width/2 < xFighter && xFighter < xEnemy+enemy.width/2+fighter.width/2 
    && yEnemy-enemy.height/2-fighter.height/2 < yFighter && yFighter < yEnemy+enemy.height/2+fighter.height/2 ) {
      hpAmount = hpAmount - fullHp/5 ;
      xEnemy = 0 ;
      yEnemy = floor(random(40,440)) ; 
    }
    if( hpAmount <= 0 ){
      gameState = GAME_LOSE ;
    }
    
    //health point
    fill(255,0,0);
    rect(45, 10, hpAmount, 30, 25) ;
    image(healthPoint,40,10) ;  
    
      break ; 
 
    case GAME_LOSE :
     if ( 200 < mouseX && mouseX < 440 && 310 < mouseY && mouseY < 350) {
      image(end1,0,0) ; 
      if(mousePressed){
        gameState = GAME_RUN ;
        hpAmount = fullHp/5 ;
        xFighter = 550 ; 
        yFighter = 300 ;
        }
      }else{
      image(end2,0,0) ;
        }          
      break ;
  }  
    
}


    void keyPressed() {
      if (key == CODED) {
        switch(keyCode){
          case UP :   upPressed = true ;   break ;
          case DOWN :   downPressed = true ;   break ;
          case LEFT :   leftPressed = true ;   break ;
          case RIGHT :   rightPressed = true ;   break ;
        }
      }
    }
    void keyReleased(){
      if(key == CODED) {
        switch(keyCode){
          case UP :   upPressed = false ;   break ;
          case DOWN :   downPressed = false ;   break ;
          case LEFT :   leftPressed = false ;   break ;
          case RIGHT :   rightPressed = false ;   break ;
        }
      }
    }
