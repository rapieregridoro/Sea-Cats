extends KinematicBody2D

export var Jogador = 0
var coordX
var coordY
var Status
var Pose
var dir
var Ataque

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func Personagem( psX,  pxY):
	
	var mx = 0
	var my = 0
	
	for q in range(2):
		
		if(Status != 0):
			
			if(Jogador[q].Pose%2 == 1):
				sndPlaySound(".\\Audio\\Char_Move.wav", SND_ASYNC);
				
			
			#Desenha
			#Anda Pose de 0 a 12
			if(Jogador[q].Status == 1):
				putimage(psX + mx + Jogador[q].x, psY + my + Jogador[q].y, Jog[q][1][Jogador[q].Pose], OR_PUT);
				putimage(psX + mx + Jogador[q].x, psY + my + Jogador[q].y, Jog[q][0][Jogador[q].Pose], AND_PUT);
				
			
			#Ataca Spt de 13 a 18
			if(Jogador[q].Status == 2):
				if(Jogador[q].Ataque >= 19):
					Jogador[q].Ataque = 13;
					putimage(psX - 15 + Jogador[q].x, psY -15 + Jogador[q].y, Jog[q][1][Jogador[q].Ataque], OR_PUT);
					putimage(psX - 15 + Jogador[q].x, psY -15 + Jogador[q].y, Jog[q][0][Jogador[q].Ataque], AND_PUT);
					Jogador[q].Ataque = Jogador[q].Ataque + 1
				if (Jogador[q].Ataque == 19):
					Jogador[q].Status = 1;
				
			
			
			#Movimenta
			if(Jogador[q].dir >= 0 && Jogador[q].dir <= 4):
				 Jogador[q].dir = Jogador[q].dir;
			else:
				 Jogador[q].dir = 0;
			if(Jogador[q].Pose >= 0 && Jogador[q].Pose <= 21):
				 Jogador[q].Pose = Jogador[q].Pose;
			else:
				Jogador[q].Pose = 0;
					Jogador[q].coordX = (Jogador[q].x + Jogador[q].x%TCelula)/TCelula;
			Jogador[q].coordY = (Jogador[q].y + Jogador[q].y%TCelula)/TCelula;
			
			if(q == 0) :
				if(GetKeyState(VK_UP)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 1) :
					Jogador[q].dir = 1;
					if (Jogador[q].dir == 1 && Onda[Atual].Mapa[Jogador[q].coordX][Jogador[q].coordY - 1] != 1):
						Jogador[q].y-=(TCelula/2);
						if(Jogador[q].Pose >= 7 || Jogador[q].Pose < 4):
							 Jogador[q].Pose = 4;
						else:
							 Jogador[q].Pose = Jagador[q].Pose + 1;
					else :
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					
				
				if(GetKeyState(VK_LEFT)&0x80 && Jogador[q].dir == 0|| Jogador[q].dir == 2) :
					Jogador[q].dir = 2;
					if (Jogador[q].dir == 2 && Onda[Atual].Mapa[Jogador[0].coordX - 1][Jogador[0].coordY] != 1):
						Jogador[0].x-=(TCelula/2);
						if(Jogador[0].Pose == 12):
							Jogador[0].Pose = 11;
						else:
							Jogador[0].Pose = 12;
					
					else :
						Jogador[q].dir = 0;
						Jogador[0].Pose = 0;
					
				
				Jogador[0].coordX = (Jogador[0].x )/TCelula ;
				Jogador[0].coordY = (Jogador[0].y )/TCelula ;
				if(GetKeyState(VK_DOWN)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 3) :
					Jogador[q].dir = 3;
					if (Jogador[q].dir == 3 && Onda[Atual].Mapa[Jogador[0].coordX][Jogador[0].coordY + 1] != 1):
						Jogador[0].y+=(TCelula/2);
						
						if(Jogador[0].Pose >= 3):
							Jogador[0].Pose = 0;
						else:
							Jogador[0].Pose = Jagador[0].Pose + 1;
					
					else :
						Jogador[q].dir = 0;
						Jogador[0].Pose = 0;
					
				
				if(GetKeyState(VK_RIGHT)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 4) :
					Jogador[q].dir = 4;
					if (Jogador[q].dir == 4 && Onda[Atual].Mapa[Jogador[0].coordX + 1][Jogador[q].coordY] != 1):
						Jogador[q].x+=(TCelula/2);
						
						if(Jogador[q].Pose == 10): Jogador[0].Pose = 9;
						else: Jogador[q].Pose = 10; 
					
					else :
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					
				
			
			
			if(q == 1) :
				#Cima
				if(GetKeyState(T_W)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 1) :
					Jogador[q].dir = 1;
					if (Jogador[q].dir == 1 && Onda[Atual].Mapa[Jogador[q].coordX][Jogador[q].coordY - 1] != 1):
						Jogador[q].y-=(TCelula/2);
						if(Jogador[q].Pose >= 7 || Jogador[q].Pose < 4): Jogador[q].Pose = 4;
						else: Jogador[q].Pose = Jogador[q].Pose + 1;
					
					else :
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					
				
				#Esquerda
				if(GetKeyState(T_A)&0x80 && Jogador[q].dir == 0|| Jogador[q].dir == 2) :
					Jogador[q].dir = 2;
					if (Jogador[q].dir == 2 && Onda[Atual].Mapa[Jogador[q].coordX - 1][Jogador[q].coordY] != 1):
						Jogador[q].x-=(TCelula/2);
						if(Jogador[q].Pose == 12) :
							Jogador[q].Pose = 11;
							 
						else: Jogador[q].Pose = 12;
					
					else :
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					
				
				Jogador[q].coordX = (Jogador[q].x )/TCelula ;
				Jogador[q].coordY = (Jogador[q].y )/TCelula ;
				#Baixo
				if(GetKeyState(T_S)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 3) :
					Jogador[q].dir = 3;
					if (Jogador[q].dir == 3 && Onda[Atual].Mapa[Jogador[q].coordX][Jogador[q].coordY + 1] != 1):
						Jogador[q].y+=(TCelula/2);
						
						if(Jogador[q].Pose >= 3): Jogador[q].Pose = 0;
						else: Jogador[q].Pose = Jogador[q].Pose + 1;
					
					else :
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					
				
				#Direita
				if(GetKeyState(T_D)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 4) :
					Jogador[q].dir = 4;
					if (Jogador[q].dir == 4 && Onda[Atual].Mapa[Jogador[q].coordX + 1][Jogador[q].coordY] != 1):
						Jogador[q].x+=(TCelula/2);
						
						if(Jogador[q].Pose == 10): Jogador[q].Pose = 9;
						else: Jogador[q].Pose = 10; 
					
					else :
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					
				
			
		
		elif(GetKeyState(T_W)&0x80 || GetKeyState(T_A)&0x80 || 
		GetKeyState(T_S)&0x80 || GetKeyState(T_D)&0x80) :
			Jogador[q].Status = 1;
		
	
	pass
#Controla o(s) Personagem(s)
