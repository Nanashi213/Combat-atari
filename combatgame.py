import pygame
import os


rojo = (255, 0, 0)
azul = (0, 0, 255)


class Tanque():

    '''
    Nombre Clase: Tanque

    Descripcion: Representar el tanque.

    Llamado: Tanque(i_tanque,coor_x,coor_y,angulo,maxbalas).

    Atributos: 
                i_tanque: la imagen del tanque(jpg, jpeg).
                tanque_rot: la direccion de la imagen del tanque.
                coor_x, coor_y: las coordenadas iniciales del tanque.
                mov_x, mov_y: el movimiento que tiene el tanque en x o y.
                angulo: toma el angulo  del tanque.
                max_balas: el maximo de balas que puede disparar
                balas: las balas que existen en el momento.
    '''

    def __init__(self,i_tanque,coor_x,coor_y,angulo,maxbalas) -> None:
        self.i_tanque=i_tanque
        self.tanque_rot=pygame.transform.rotate(i_tanque, 90)
        self.coor_x=coor_x
        self.coor_y=coor_y
        self.mov_x=0
        self.mov_y=0
        self.puntaje=0
        self.angulo=angulo
        self.max=maxbalas
        self.balas= []

    '''
    Metodo: avanzar
    descripcion: rota la imagen segun el movimiento x y y del tanque y cambia el 
    angulo.

    '''
        
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

    '''
    Metodo: disparo
    Descripcion: realiza el movimiento de cada bala disparada y revisa el choque de la bala con un 
    obstaculo para destruirla o el choque con el tanque enemigo para aumentar el puntaje.
    Parametros: 
            ventana: la ventana donde se dibuja la bala
            color: el color de la bala.
            rectangulos: los obstaculos del mapa.
            tanque: el tanque enemigo
    '''
      
    def disparo(self,ventana,color,rectangulos,tanque):
        i =0 #Variable para saber el indice de la bala 
        for bala in self.balas: 
            bala.coor_x+=bala.mov_x
            bala.coor_y+=bala.mov_y
            ba = pygame.draw.rect(ventana,color,(bala.coor_x,bala.coor_y,6,6)) 
            choque = bala.choquebala(ba,rectangulos) 
            if choque==0:
                self.balas.pop(i)
            if ba.colliderect(tanque):
                self.balas.pop(i)
                self.puntaje+=1
            i=i+1

            
class Combat():
    '''
    Nombre Clase:  Combat

    Descripcion: clase que genera los obstaculos del tanque y el choque del tanque

    Llamado: Combat(ventana)
             ventana: la ventana donde estan los obstaculos
             
    Atributos:
            rectangulos: todos los obstaculos del mapa

                
    '''

    def __init__(self,ventana) -> None:
        rectangulo_1 = pygame.draw.rect(ventana, (255,255,255), (0, 33, 800, 20))
        rectangulo_2 = pygame.draw.rect(ventana, (255,255,255), (0, 490, 800, 20))#barra abajo
        rectangulo_3 = pygame.draw.rect(ventana, (255,255,255), (0, 33, 20, 800))#barra izquierda
        rectangulo_4 = pygame.draw.rect(ventana, (255,255,255), (782, 33, 20, 800))#barra derecha
        rectangulo_5 = pygame.draw.rect(ventana, (255,255,255), (216, 248, 79, 37))#barra cruz izquierda
        rectangulo_6 = pygame.draw.rect(ventana, (255,255,255), (503, 248, 79, 37))#barra cruz derecha
        rectangulo_7 = pygame.draw.rect(ventana, (255,255,255), (380, 129, 37, 79))#barra cruz arriba
        rectangulo_8 = pygame.draw.rect(ventana, (255,255,255), (380, 328, 37, 79))#barra cruz arriba
        rectangulo_9 =pygame.draw.rect(ventana,(0,0,0),(106,204,40,23))#guarida izquierda
        rectangulo_10 =pygame.draw.rect(ventana,(0,0,0),(125,207,23,122))
        rectangulo_11 = pygame.draw.rect(ventana,(0,0,0),(106,309,40,22))

        rectangulo_12 =pygame.draw.rect(ventana,(0,0,0),(663,204,40,23))#guarida derecha
        rectangulo_13 =pygame.draw.rect(ventana,(0,0,0),(663,207,23,122))
        rectangulo_14 = pygame.draw.rect(ventana,(0,0,0),(663,309,40,22))

        self.rectangulos =[rectangulo_1,rectangulo_2,rectangulo_3,rectangulo_4,rectangulo_5
        ,rectangulo_6,rectangulo_7,rectangulo_8,rectangulo_9,rectangulo_10,rectangulo_11,
        rectangulo_12,rectangulo_13,rectangulo_14]

    '''
    Metodo: choqueoftanque
    Descripcion: revisa si el tanque ha colisionado con algun obstaculo
    Parametros: 
                coor_x,coor_y: las cordenadas del tanque
                mov_x,mov_y: el movimiento x y y del tanque para retroceder en caso de colision
                cuadro: el cuadro que representa el tanque
                cuadro: el tanque contrario 
    retorna las coor_x y coor_y para el tanque

    '''
    def choqueOfTanque(self,coor_x,coor_y,mov_x,mov_y,cuadro,cuadro0):      
        for i in self.rectangulos:
            if cuadro.colliderect(i):
                if mov_y == 0:
                    coor_x-=mov_x
                if mov_x == 0:
                    coor_y-=mov_y
                else:
                    coor_x-=mov_x
                    coor_y-=mov_y
        if cuadro0.colliderect(cuadro):
            if mov_y == 0:
                    coor_x-=mov_x
            if mov_x == 0:
                coor_y-=mov_y
            else:
                coor_x-=mov_x
                coor_y-=mov_y
                    
        return [coor_x,coor_y]
    

    
class Balas():
    '''
    Nombre Clase: Balas

    Descripcion: representacion de una bala

    Llamado: Balas(coor_x,coor_y,angulo)

    Atributos: 
                coor_x, coor_y: las coordenadas iniciales de la bala.
                mov_x, mov_y: el movimiento que tiene el tanque en x o y.
                angulo: toma el angulo al que fue disparada la bal.
    '''

    def __init__(self,coor_x,coor_y,angulo):
        self.coor_x=coor_x
        self.coor_y=coor_y
        self.mov_x=0
        self.mov_y=0
        self.ang=angulo
        self.angulo()


    '''
    Metodo: angulo
    Descripcion: segun el angulo del que disparada la bala hace el movimiento x o movimiento y
    '''
        
    def angulo(self):
        if self.ang ==0 or self.ang == 315 :
            self.mov_x=7
            self.coor_x+=20
        if self.ang ==180 or self.ang == 135 or self.ang ==225 :
            self.mov_x=-7
            self.coor_x-=20
        if self.ang ==270  or self.ang == 315 or self.ang ==225 :
            self.mov_y=7
            self.coor_y+=20
        if self.ang ==90 or self.ang == 135  :
            self.mov_y=-7
            self.coor_y-=20
        if self.ang ==45:
            self.mov_x=7
            self.mov_y=-7
            self.coor_x+=20
            self.coor_y-=6
            
    '''
    Metodo: choque bala
    Descripcion: 
    Parametros: 
            cuadro: bala 
            rectangulos: obstaculos

    retorna 0 si se hay colision
    retorna 1 si no hay colision

    '''
         
    def choquebala(self,cuadro,rectangulos):
        for i in rectangulos:
            if cuadro.colliderect(i):
                return 0
        return 1



def play_combat():
    # Llamado:      play_combat()
    # Descripcion:  funcion que maneja el juego creando la ventana y las acciones realizadas 
    # con los tanques 


    pygame.init()
    pygame.mixer.init()
    pygame.font.init()
    azul=(0,0,255)
    rojo=(255,0,0)
    fuenteletra = pygame.font.SysFont('Eras Bold ITC',45)
    tam = (800,511)
    ventana = pygame.display.set_mode(tam)
    clock=pygame.time.Clock()
    tablero=pygame.image.load(os.path.join("COMBAT/Combat.svg.png"))
    tanquer=pygame.image.load(os.path.join("COMBAT/rojo.png"))
    tanquea=pygame.image.load(os.path.join("COMBAT/azul.png"))
    
    tanquea = pygame.transform.rotate(tanquea, 180)
    tanquer = pygame.transform.rotate(tanquer, 0)
    game_over=False
        
    tanque1=Tanque(tanquea,750,270,180,10)
    
    tanque2=Tanque(tanquer,30,250,0,10)
    
    combat= Combat(ventana)

    while not game_over:
        if tanque1.puntaje <20 and tanque2.puntaje<20:
            #Mientras el puntaje sea menor a 20 el juego seguira
            for evento in pygame.event.get():
                if evento.type == pygame.QUIT:
                    game_over=True

                '''
                segun la tecla presionada afecta el movimiento x y y del tanque
                '''
                if evento.type == pygame.KEYDOWN:
                    if evento.key == pygame.K_LEFT:
                            tanque1.mov_x=-3
                    if evento.key == pygame.K_RIGHT:
                            tanque1.mov_x=3
                    if evento.key == pygame.K_UP:
                            tanque1.mov_y=-3
                    if evento.key == pygame.K_DOWN:
                            tanque1.mov_y = 3                    
                    if evento.key == pygame.K_RCTRL and len(tanque1.balas)<tanque1.max:
                        #Agruega una bala si no esta al limite
                        tanque1.balas.append(Balas(tanque1.coor_x,tanque1.coor_y,tanque1.angulo))
        
                    if evento.key == pygame.K_a:
                            tanque2.mov_x=-3                      
                    if evento.key == pygame.K_d:
                            tanque2.mov_x=3
                    if evento.key == pygame.K_w:
                            tanque2.mov_y=-3
                    if evento.key == pygame.K_s:
                            tanque2.mov_y = 3
                    if evento.key == pygame.K_LCTRL and len(tanque2.balas)<tanque2.max:
                        #Agruega una bala si no esta al limite
                        tanque2.balas.append(Balas(tanque2.coor_x+15,tanque2.coor_y+15,tanque2.angulo))
                        print(tanque2.angulo)

                '''
                segun la tecla que se dejo de presiona afecta el movimiento x y y del tanque
                '''          
                if evento.type == pygame.KEYUP:
                    if evento.key == pygame.K_LEFT:
                            tanque1.mov_x=0                        
                    if evento.key == pygame.K_RIGHT:
                            tanque1.mov_x=0
                    if evento.key == pygame.K_UP:
                            tanque1.mov_y=0                  
                    if evento.key == pygame.K_DOWN:
                            tanque1.mov_y = 0

                    if evento.key == pygame.K_a:
                            tanque2.mov_x=0                         
                    if evento.key == pygame.K_d:
                            tanque2.mov_x=0
                    if evento.key == pygame.K_w:
                            tanque2.mov_y=0            
                    if evento.key == pygame.K_s:
                            tanque2.mov_y = 0
            

            tanque1.avanzar()
            tanque2.avanzar()
            tanque1.coor_x+=tanque1.mov_x
            tanque1.coor_y+=tanque1.mov_y
            tanque2.coor_x+=tanque2.mov_x
            tanque2.coor_y+=tanque2.mov_y



            #Aumenta el tamaño del cuadro del tanque si esta en diagonal
            if tanque1.angulo in [45,135,225,315]:
                tam_cuadroa=50
            else:
                tam_cuadroa=40
            if tanque2.angulo in [45,135,225,315]:
                tam_cuadror=50
            else:
                tam_cuadror=40

            
            #Cuadros que representan los tanques    
            cuadro_a=pygame.draw.rect(ventana,(0,0,0),(tanque1.coor_x-20,tanque1.coor_y-20,tam_cuadroa,tam_cuadroa))
            cuadro_r=pygame.draw.rect(ventana,(0,0,0),(tanque2.coor_x,tanque2.coor_y,tam_cuadror,tam_cuadror))
            
            #Actualiza la coordenada si hay choque de un tanque
            tanque1.coor_x,tanque1.coor_y=combat.choqueOfTanque(tanque1.coor_x,tanque1.coor_y,tanque1.mov_x,tanque1.mov_y,cuadro_a,cuadro_r)
            tanque2.coor_x,tanque2.coor_y=combat.choqueOfTanque(tanque2.coor_x,tanque2.coor_y,tanque2.mov_x,tanque2.mov_y,cuadro_r,cuadro_a)
            

            ventana.fill((0,0,0))
            ventana.blit(tablero,(0,0))
            
            ventana.blit(tanque1.tanque_rot,(tanque1.coor_x-20,tanque1.coor_y-17))  
            ventana.blit(tanque2.tanque_rot,(tanque2.coor_x,tanque2.coor_y))  
            
            tanque1.disparo(ventana,azul,combat.rectangulos,cuadro_r)
            tanque2.disparo(ventana,rojo,combat.rectangulos,cuadro_a)
            
            texto_puntajea=fuenteletra.render(str(tanque1.puntaje),1,azul)
            texto_puntajer=fuenteletra.render(str(tanque2.puntaje),1,rojo)
            ventana.blit(texto_puntajea,(537,2))   
            ventana.blit(texto_puntajer,(200,2))   
            con=0
            
        else:
            '''
            Mensaje cuando uno de los jugadores a ganado
            '''
            ventana.fill((0,0,0))
            ventana.blit(tablero,(0,0))
            if con>=100:
                game_over=True
            texto_puntajea=fuenteletra.render(str(tanque1.puntaje),1,azul)
            texto_puntajer=fuenteletra.render(str(tanque2.puntaje),1,rojo)
            texto=fuenteletra.render(str("JUEGO TERMINADO"),1,(0,0,0))
            ventana.blit(texto,(250,250)) 
            ventana.blit(texto_puntajea,(537,2))   
            ventana.blit(texto_puntajer,(200,2))  
            
            con+=1 
            
        pygame.display.update()
        pygame.display.flip()
        clock.tick(30)
    
    
    pygame.quit()
    
