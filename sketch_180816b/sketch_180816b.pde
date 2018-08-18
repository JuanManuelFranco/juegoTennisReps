int pantallaJuego= 0;
int bolaX, bolaY;
int tamanoBola=20;
int colorBola=#66FF5D;
float gravedad=0.6;
float velocidadY=0;
float velocidadX=5;
float friccion =0.1;
float friccionAire=0.0001;
color raquetaColor = #D1CCC8;
float anchoRaqueta= 100;
float altoRaqueta = 10;
int rateRaqueta = 20;
float rot=0;
int score = 0;
PImage bg;
float lastAddTime = 0;


void setup()
{

  size(600,900);
  bolaX= width/2;
  bolaY=0;
  bg = loadImage("tenis.jpg");
  smooth();

}

void draw()
{


  if (pantallaJuego ==0)
  {
    iniciarPantalla();
  }else if (pantallaJuego ==1)
  {
    pantallaJuego();
  }
  else if (pantallaJuego ==2)
  {
    gameOver();
  }
}

void iniciarPantalla(){
  background(0);
  textAlign(CENTER,CENTER);
  textSize(70);
  text("Tennis reps", height/3, width/2 - 20);
  textSize(15);

  text ("Click para empezar", height/3, width);

}
void pantallaJuego(){
  image(bg,0,0);

  drawBola();
  dibujarRaqueta();
  aplicarGravedad();
  enPantalla();
  reboteRaqueta();
  reboteX();
  printScore();
}
void gameOver(){ 
  background(0);
  textAlign(CENTER);
  fill(255);
  textSize(30);
  text("Game Over", height/3, width/2 - 20);
  textSize(15);
  text("Click to Restart", height/3, width/2 + 10);
  pantallaJuego = 2;
}

public void mousePressed(){
  if (pantallaJuego==0){
    comenzarPartida();
  }
    if (pantallaJuego==2) {
    restart();
  }
}
void restart() {
  score = 0;
  bolaX= width/2;
  bolaY=0;
  lastAddTime = 0;
  pantallaJuego = 1;
}

void comenzarPartida(){
  pantallaJuego=1;
}

void drawBola(){
  fill(colorBola);
  ellipse(bolaX,bolaY,tamanoBola,tamanoBola);
}
void aplicarGravedad(){
  velocidadY += gravedad;
  bolaY += velocidadY;
  velocidadY-=(velocidadY *friccionAire);
}

void rebotarBot(int surface){
  bolaY= surface - (tamanoBola/2);
  velocidadY*=-1;
  velocidadY-=(velocidadY *friccion);

}


void rebotarTop(int surface){
  bolaY= surface + (tamanoBola/2);
  velocidadY*=-1;
  velocidadY-=(velocidadY * friccion);

}
void enPantalla(){
  if(bolaY+(tamanoBola/2) >height){
    //rebotarBot(height);
    gameOver();
  }
  if(bolaY-(tamanoBola/2) <0){
    rebotarTop(0);
  }
  if (bolaX-(tamanoBola/2) < 0){
    reboteLeft(0);
  }
  if (bolaX+(tamanoBola/2) > width){
    reboteRight(width);
  }
}
void dibujarRaqueta(){
  fill(raquetaColor);
  
  rectMode(CENTER);
//rotate(PI/4);
  rect(mouseX,mouseY,anchoRaqueta,altoRaqueta);
  /*
    translate(mouseX, mouseY);
  rotate(rot);
  rect(0,0,anchoRaqueta,altoRaqueta);
  rot=PI/4;
  */
}

void reboteRaqueta(){
  float arribaRaqueta = mouseY - pmouseY;
  if((bolaX+(tamanoBola/2) > mouseX -(anchoRaqueta/2)) && (bolaX-(tamanoBola/2) < mouseX+(anchoRaqueta/2))){
    if(dist(bolaX,bolaY,bolaX,mouseY)<=(tamanoBola/2)+ abs(arribaRaqueta)){
      rebotarBot(mouseY);
      velocidadX = (bolaX - mouseX)/5;
            score();

      if(arribaRaqueta<0){
        bolaY+= arribaRaqueta;
        velocidadY +=arribaRaqueta;
                    score();

      }
                 // score();

    }
    
  }
}
void reboteX(){
  bolaX += velocidadX;
  velocidadX -= (velocidadX * friccionAire);
}
void reboteRight(int surface){
  bolaX = surface-(tamanoBola/2);
  velocidadX*=-1;
  velocidadX -= (velocidadX * friccion);
}
void reboteLeft(int surface){
  bolaX = surface+(tamanoBola/2);
  velocidadX*=-1;
  velocidadX -= (velocidadX * friccion);
}
void score() {
  score++;
}
void printScore(){
  textAlign(CENTER);
  fill(255);
  textSize(70); 
  text(score, height/3, 100);
}
      
