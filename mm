import pygame
import os


Rojo = (255, 0, 0)
Azul = (0, 0, 255)
    
class Tanque():
    def __init__(self,i_tanque,coor_x,coor_y,angulo) -> None:
        self.i_tanque=i_tanque
        self.tanque_rot=pygame.transform.rotate(i_tanque, 90)
        self.coor_x=coor_x
        self.coor_y=coor_y
        self.mov_x=0
        self.mov_y=0
        self.puntaje=0
        self.angulo=angulo
        self.balas= []
        
    def avanzar(self):
        
        if self.mov_x==0 and self.mov_y==-3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, -180)
            self.angulo=90
        if self.mov_x==0 and self.mov_y==3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, 0)
            self.angulo=270
        if self.mov_x==-3 and self.mov_y==0:
            self.angulo=180
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, -90)
        if self.mov_x==3 and self.mov_y==0:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, 90)
            self.angulo=0
        if self.mov_x==-3 and self.mov_y==-3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, -135)
            self.angulo=135
        if self.mov_x==3 and self.mov_y==-3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, -225)
            self.angulo=45
        if self.mov_x==3 and self.mov_y==3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, 45)
            self.angulo=315
        if self.mov_x==-3 and self.mov_y==3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, -45)
            self.angulo=225
            
          
class Combat():

    def obstaculos(self,Ventana,coor_x,coor_y,mov_x,mov_y,Cuadro):

        rectangulo_1 = pygame.draw.rect(Ventana, (255,255,255), (0, 33, 800, 20))
        rectangulo_2 = pygame.draw.rect(Ventana, (255,255,255), (0, 490, 800, 20))#barra abajo
        rectangulo_3 = pygame.draw.rect(Ventana, (255,255,255), (0, 33, 20, 800))#barra izquierda
        rectangulo_4 = pygame.draw.rect(Ventana, (255,255,255), (782, 33, 20, 800))#barra derecha
        rectangulo_5 = pygame.draw.rect(Ventana, (255,255,255), (216, 248, 79, 37))#barra cruz izquierda
        rectangulo_6 = pygame.draw.rect(Ventana, (255,255,255), (503, 248, 79, 37))#barra cruz derecha
        rectangulo_7 = pygame.draw.rect(Ventana, (255,255,255), (380, 129, 37, 79))#barra cruz arriba
        rectangulo_8 = pygame.draw.rect(Ventana, (255,255,255), (380, 328, 37, 79))#barra cruz arriba
        rectangulo_9 =pygame.draw.rect(Ventana,(0,0,0),(106,204,40,23))#guarida izquierda
        rectangulo_10 =pygame.draw.rect(Ventana,(0,0,0),(125,207,23,122))
        rectangulo_11 = pygame.draw.rect(Ventana,(0,0,0),(106,309,40,22))

        rectangulo_12 =pygame.draw.rect(Ventana,(0,0,0),(663,204,40,23))#guarida derecha
        rectangulo_13 =pygame.draw.rect(Ventana,(0,0,0),(663,207,23,122))
        rectangulo_14 = pygame.draw.rect(Ventana,(0,0,0),(663,309,40,22))

        rectangulos =[rectangulo_1,rectangulo_2,rectangulo_3,rectangulo_4,rectangulo_5
        ,rectangulo_6,rectangulo_7,rectangulo_8,rectangulo_9,rectangulo_10,rectangulo_11,
        rectangulo_12,rectangulo_13,rectangulo_14]
        for i in rectangulos:
            if Cuadro.colliderect(i):
                if mov_x==-3 and mov_y==-3:
                    coor_x-=mov_x
                    coor_y-=mov_y
                if mov_x==3 and mov_y==-3:
                    coor_x-=mov_x
                    coor_y-=mov_y
                if mov_x==3 and mov_y==3:
                    coor_x-=mov_x
                    coor_y-=mov_y
                if mov_x==-3 and mov_y==3:
                    coor_x-=mov_x
                    coor_y-=mov_y
                if mov_y == 0:
                    coor_x-=mov_x
                if mov_x == 0:
                    coor_y-=mov_y
                    
                    
        return [coor_x,coor_y]
                    

class Balas():

    def __init__(self,coor_x,coor_y,angulo,max):
        self.coor_x=coor_x
        self.coor_y=coor_y
        self.mov_x=0
        self.mov_y=0
        self.angulo=angulo
        self.max=max
        self.balas= []
        
    def angulo(self):
        if self.angulo ==0 or self.angulo == 315 or self.angulo ==45 :
            self.mov_x=3
        if self.angulo ==180 or self.angulo == 135 or self.angulo ==225 :
            self.mov_x=-3
        if self.angulo ==90  or self.angulo == 315 or self.angulo ==225 :
            self.mov_y=3
        if self.angulo ==270 or self.angulo == 135 or self.angulo ==45  :
            self.mov_y=-3

    def bala(self,Ventana,color):
        pygame.draw.rect(Ventana,(0,0,0),(self.coor_x,self.coor_y,6,6))    
        
    

def Jugar():
    pygame.init()
    pygame.mixer.init()
    pygame.font.init()
    FuenteLetra = pygame.font.SysFont('Eras Bold ITC',45)
    tam = (800,511)
    Ventana = pygame.display.set_mode(tam)
    Clock=pygame.time.Clock()
    Tablero=pygame.image.load(os.path.join("Combat.svg.png"))
    tanquer=pygame.image.load(os.path.join("rojo.png"))
    tanquea=pygame.image.load(os.path.join("azul.png"))
    
    tanquea = pygame.transform.rotate(tanquea, 180)
    tanquer = pygame.transform.rotate(tanquer, 0)
    GameOver=False
        
    Tanque1=Tanque(tanquea,750,270,180)
    balas1=Balas(750,270,180,50)
    
    Tanque2=Tanque(tanquer,30,250,0)
    balas2=Balas(30,250,0,50)
    

    combat= Combat()
    x=0
    while not GameOver:
        for Evento in pygame.event.get():
            if Evento.type == pygame.QUIT:
                GameOver=True
            if Evento.type == pygame.KEYDOWN:
                if Evento.key == pygame.K_LEFT:
                        Tanque1.mov_x=-3
                if Evento.key == pygame.K_RIGHT:
                        Tanque1.mov_x=3
                if Evento.key == pygame.K_UP:
                        Tanque1.mov_y=-3
                if Evento.key == pygame.K_DOWN:
                        Tanque1.mov_y = 3                    
                if Evento.key == pygame.K_RCTRL and len(Tanque1.balas)<balas1.max:
                    '''balas1.angulo=Tanque1.angulo
                    balas1.disparar()
                    x=1'''
    
                if Evento.key == pygame.K_a:
                        Tanque2.mov_x=-3                      
                if Evento.key == pygame.K_d:
                        Tanque2.mov_x=3
                if Evento.key == pygame.K_w:
                        Tanque2.mov_y=-3
                if Evento.key == pygame.K_s:
                        Tanque2.mov_y = 3
                if Evento.key == pygame.K_LCTRL and len(balas2.balas)<balas2.max:
                    pass

                        
            if Evento.type == pygame.KEYUP:
                if Evento.key == pygame.K_LEFT:
                        Tanque1.mov_x=0                        
                if Evento.key == pygame.K_RIGHT:
                        Tanque1.mov_x=0
                if Evento.key == pygame.K_UP:
                        Tanque1.mov_y=0                  
                if Evento.key == pygame.K_DOWN:
                        Tanque1.mov_y = 0

                if Evento.key == pygame.K_a:
                        Tanque2.mov_x=0                         
                if Evento.key == pygame.K_d:
                        Tanque2.mov_x=0
                if Evento.key == pygame.K_w:
                        Tanque2.mov_y=0            
                if Evento.key == pygame.K_s:
                        Tanque2.mov_y = 0
        

        Tanque1.avanzar()
        Tanque2.avanzar()
        Tanque1.coor_x+=Tanque1.mov_x
        Tanque1.coor_y+=Tanque1.mov_y
        Tanque2.coor_x+=Tanque2.mov_x
        Tanque2.coor_y+=Tanque2.mov_y

        balas1.coor_x+=balas1.mov_x
        balas1.coor_y+=balas1.mov_y
        balas2.coor_x+=balas2.mov_x
        balas2.coor_y+=balas2.mov_y

        
            
        if Tanque1.angulo in [45,135,225,315]:
            tam_CuadroA=50
        else:
            tam_CuadroA=40
        if Tanque2.angulo in [45,135,225,315]:
            tam_CuadroR=50
        else:
            tam_CuadroR=40
        CuadroA=pygame.draw.rect(Ventana,(0,0,0),(Tanque1.coor_x-20,Tanque1.coor_y-20,tam_CuadroA,tam_CuadroA))
        CuadroR=pygame.draw.rect(Ventana,(0,0,0),(Tanque2.coor_x,Tanque2.coor_y,tam_CuadroR,tam_CuadroR))

        Tanque1.coor_x,Tanque1.coor_y=combat.obstaculos(Ventana,Tanque1.coor_x,Tanque1.coor_y,Tanque1.mov_x,Tanque1.mov_y,CuadroA)
        Tanque2.coor_x,Tanque2.coor_y=combat.obstaculos(Ventana,Tanque2.coor_x,Tanque2.coor_y,Tanque2.mov_x,Tanque2.mov_y,CuadroR)
        
        print(x)

        Ventana.fill((0,0,0))
        Ventana.blit(Tablero,(0,0))
        balas1.bala(Ventana,(0,0,0))
        
        Ventana.blit(Tanque1.tanque_rot,(Tanque1.coor_x-20,Tanque1.coor_y-17))  
        Ventana.blit(Tanque2.tanque_rot,(Tanque2.coor_x,Tanque2.coor_y))  
        
        Texto_PuntajeA=FuenteLetra.render(str(Tanque1.puntaje),1,Azul)
        Texto_PuntajeR=FuenteLetra.render(str(Tanque2.puntaje),1,Rojo)
        Ventana.blit(Texto_PuntajeA,(537,2))   
        Ventana.blit(Texto_PuntajeR,(200,2))   
        pygame.display.update()
        pygame.display.flip()
        Clock.tick(30)

        
    pygame.quit()

if __name__=='__main__':
    Jugar()

import pygame
import os


Rojo = (255, 0, 0)
Azul = (0, 0, 255)
    
class Tanque():
    def __init__(self,i_tanque,coor_x,coor_y,angulo) -> None:
        self.i_tanque=i_tanque
        self.tanque_rot=pygame.transform.rotate(i_tanque, 90)
        self.coor_x=coor_x
        self.coor_y=coor_y
        self.mov_x=0
        self.mov_y=0
        self.puntaje=0
        self.angulo=angulo
        
    def avanzar(self):
        
        if self.mov_x==0 and self.mov_y==-3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, -180)
            self.angulo=90
        if self.mov_x==0 and self.mov_y==3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, 0)
            self.angulo=270
        if self.mov_x==-3 and self.mov_y==0:
            self.angulo=180
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, -90)
        if self.mov_x==3 and self.mov_y==0:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, 90)
            self.angulo=0
        if self.mov_x==-3 and self.mov_y==-3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, -135)
            self.angulo=135
        if self.mov_x==3 and self.mov_y==-3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, -225)
            self.angulo=45
        if self.mov_x==3 and self.mov_y==3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, 45)
            self.angulo=315
        if self.mov_x==-3 and self.mov_y==3:
            self.tanque_rot= pygame.transform.rotate(self.i_tanque, -45)
            self.angulo=225
            
          
class Combat():

    def obstaculos(self,Ventana,coor_x,coor_y,mov_x,mov_y,Cuadro):

        rectangulo_1 = pygame.draw.rect(Ventana, (255,255,255), (0, 33, 800, 20))
        rectangulo_2 = pygame.draw.rect(Ventana, (255,255,255), (0, 490, 800, 20))#barra abajo
        rectangulo_3 = pygame.draw.rect(Ventana, (255,255,255), (0, 33, 20, 800))#barra izquierda
        rectangulo_4 = pygame.draw.rect(Ventana, (255,255,255), (782, 33, 20, 800))#barra derecha
        rectangulo_5 = pygame.draw.rect(Ventana, (255,255,255), (216, 248, 79, 37))#barra cruz izquierda
        rectangulo_6 = pygame.draw.rect(Ventana, (255,255,255), (503, 248, 79, 37))#barra cruz derecha
        rectangulo_7 = pygame.draw.rect(Ventana, (255,255,255), (380, 129, 37, 79))#barra cruz arriba
        rectangulo_8 = pygame.draw.rect(Ventana, (255,255,255), (380, 328, 37, 79))#barra cruz arriba
        rectangulo_9 =pygame.draw.rect(Ventana,(0,0,0),(106,204,40,23))#guarida izquierda
        rectangulo_10 =pygame.draw.rect(Ventana,(0,0,0),(125,207,23,122))
        rectangulo_11 = pygame.draw.rect(Ventana,(0,0,0),(106,309,40,22))

        rectangulo_12 =pygame.draw.rect(Ventana,(0,0,0),(663,204,40,23))#guarida derecha
        rectangulo_13 =pygame.draw.rect(Ventana,(0,0,0),(663,207,23,122))
        rectangulo_14 = pygame.draw.rect(Ventana,(0,0,0),(663,309,40,22))

        rectangulos =[rectangulo_1,rectangulo_2,rectangulo_3,rectangulo_4,rectangulo_5
        ,rectangulo_6,rectangulo_7,rectangulo_8,rectangulo_9,rectangulo_10,rectangulo_11,
        rectangulo_12,rectangulo_13,rectangulo_14]
        for i in rectangulos:
            if Cuadro.colliderect(i):
                if mov_x==-3 and mov_y==-3:
                    coor_x-=mov_x
                    coor_y-=mov_y
                if mov_x==3 and mov_y==-3:
                    coor_x-=mov_x
                    coor_y-=mov_y
                if mov_x==3 and mov_y==3:
                    coor_x-=mov_x
                    coor_y-=mov_y
                if mov_x==-3 and mov_y==3:
                    coor_x-=mov_x
                    coor_y-=mov_y
                if mov_y == 0:
                    coor_x-=mov_x
                if mov_x == 0:
                    coor_y-=mov_y
                    
                    
        return [coor_x,coor_y]
                    

class Balas():

    def __init__(self,coor_x,coor_y,angulo,max):
        self.coor_x=coor_x
        self.coor_y=coor_y
        self.mov_x=0
        self.mov_y=0
        self.angulo=angulo
        self.balas= []
        self.max=max
    
    def disparar(self):
        if self.angulo ==0 :
            self.mov_x=3
        if self.angulo ==180:
            self.mov_x=-3
        if self.angulo ==90:
            self.mov_y=3
        if self.angulo ==270:
            self.mov_y=-3

    def bala(self,Ventana,color):
        bala=pygame.draw.rect(Ventana,(0,0,0),(self.coor_x,self.coor_y,3,3))    
        
    

def Jugar():
    pygame.init()
    pygame.mixer.init()
    pygame.font.init()
    FuenteLetra = pygame.font.SysFont('Eras Bold ITC',45)
    tam = (800,511)
    Ventana = pygame.display.set_mode(tam)
    Clock=pygame.time.Clock()
    Tablero=pygame.image.load(os.path.join("Combat.svg.png"))
    tanquer=pygame.image.load(os.path.join("rojo.png"))
    tanquea=pygame.image.load(os.path.join("azul.png"))
    
    tanquea = pygame.transform.rotate(tanquea, 180)
    tanquer = pygame.transform.rotate(tanquer, 0)
    GameOver=False
        
    Tanque1=Tanque(tanquea,750,270,180)
    balas1=Balas(750,270,180,50)
    
    Tanque2=Tanque(tanquer,30,250,0)
    balas2=Balas(30,250,0,50)
    

    combat= Combat()
    x=0
    while not GameOver:
        for Evento in pygame.event.get():
            if Evento.type == pygame.QUIT:
                GameOver=True
            if Evento.type == pygame.KEYDOWN:
                if Evento.key == pygame.K_LEFT:
                        Tanque1.mov_x=-3
                if Evento.key == pygame.K_RIGHT:
                        Tanque1.mov_x=3
                if Evento.key == pygame.K_UP:
                        Tanque1.mov_y=-3
                if Evento.key == pygame.K_DOWN:
                        Tanque1.mov_y = 3                    
                if Evento.key == pygame.K_RCTRL and len(balas1.balas)<balas1.max:
                    balas1.angulo=Tanque1.angulo
                    balas1.disparar()
                    x=1
    
                if Evento.key == pygame.K_a:
                        Tanque2.mov_x=-3                      
                if Evento.key == pygame.K_d:
                        Tanque2.mov_x=3
                if Evento.key == pygame.K_w:
                        Tanque2.mov_y=-3
                if Evento.key == pygame.K_s:
                        Tanque2.mov_y = 3
                if Evento.key == pygame.K_LCTRL and len(balas2.balas)<balas2.max:
                    pass

                        
            if Evento.type == pygame.KEYUP:
                if Evento.key == pygame.K_LEFT:
                        Tanque1.mov_x=0                        
                if Evento.key == pygame.K_RIGHT:
                        Tanque1.mov_x=0
                if Evento.key == pygame.K_UP:
                        Tanque1.mov_y=0                  
                if Evento.key == pygame.K_DOWN:
                        Tanque1.mov_y = 0

                if Evento.key == pygame.K_a:
                        Tanque2.mov_x=0                         
                if Evento.key == pygame.K_d:
                        Tanque2.mov_x=0
                if Evento.key == pygame.K_w:
                        Tanque2.mov_y=0            
                if Evento.key == pygame.K_s:
                        Tanque2.mov_y = 0
        

        Tanque1.avanzar()
        Tanque2.avanzar()
        Tanque1.coor_x+=Tanque1.mov_x
        Tanque1.coor_y+=Tanque1.mov_y
        Tanque2.coor_x+=Tanque2.mov_x
        Tanque2.coor_y+=Tanque2.mov_y

        balas1.coor_x+=balas1.mov_x
        balas1.coor_y+=balas1.mov_y
        balas2.coor_x+=balas2.mov_x
        balas2.coor_y+=balas2.mov_y

        
            
        if Tanque1.angulo in [45,135,225,315]:
            tam_CuadroA=50
        else:
            tam_CuadroA=40
        if Tanque2.angulo in [45,135,225,315]:
            tam_CuadroR=50
        else:
            tam_CuadroR=40
        CuadroA=pygame.draw.rect(Ventana,(0,0,0),(Tanque1.coor_x-20,Tanque1.coor_y-20,tam_CuadroA,tam_CuadroA))
        CuadroR=pygame.draw.rect(Ventana,(0,0,0),(Tanque2.coor_x,Tanque2.coor_y,tam_CuadroR,tam_CuadroR))

        Tanque1.coor_x,Tanque1.coor_y=combat.obstaculos(Ventana,Tanque1.coor_x,Tanque1.coor_y,Tanque1.mov_x,Tanque1.mov_y,CuadroA)
        Tanque2.coor_x,Tanque2.coor_y=combat.obstaculos(Ventana,Tanque2.coor_x,Tanque2.coor_y,Tanque2.mov_x,Tanque2.mov_y,CuadroR)
        
        print(x)

        Ventana.fill((0,0,0))
        Ventana.blit(Tablero,(0,0))
        balas1.bala(Ventana,(0,0,0))
        
        Ventana.blit(Tanque1.tanque_rot,(Tanque1.coor_x-20,Tanque1.coor_y-17))  
        Ventana.blit(Tanque2.tanque_rot,(Tanque2.coor_x,Tanque2.coor_y))  
        
        Texto_PuntajeA=FuenteLetra.render(str(Tanque1.puntaje),1,Azul)
        Texto_PuntajeR=FuenteLetra.render(str(Tanque2.puntaje),1,Rojo)
        Ventana.blit(Texto_PuntajeA,(537,2))   
        Ventana.blit(Texto_PuntajeR,(200,2))   
        pygame.display.update()
        pygame.display.flip()
        Clock.tick(30)

        
    pygame.quit()

if __name__=='__main__':
    Jugar()

