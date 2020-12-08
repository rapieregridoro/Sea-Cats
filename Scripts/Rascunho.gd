#Jogo desenvolvido para nota de Programação II e Tecnologia de Redes de Computadores na Turma JogosNA2


"""Grupo --------------------------

Marcelo Hiroaki Hisatomi
Rodrigo Pereira Caetano da Silva
Virginia Cardoso de Toledo

"""


"""Linkers ------------------------

-lbgi
-lgdi32
-lcomdlg32
-luuid
-loleaut32
-lole32
-lwinmm

"""


#Bibliotecas --------------------



#include<iostream>
#include<graphics.h>
#include<conio.h>
#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<MMsystem.h>
#include<windows.h>
#include<sqlite3.h>

#using namespace std;


#Definições ---------------------

#Dimenções
#define Larg 1080
#define Altu 720
	#Tela
	
#define DimP 56
	#Coordenada
	
#define XMapa 246
#define YMapa 123
	#Inicio do Mapa Jogavel

#define TamanhoX 11
#define TamanhoY 10
	#Colunas e Linhas

#define NFases 4
	#Numero de Fases

#define Plv 10
#define Fnt 10
	#Numero de inimigos
	
#Menu
#define JInicio 0
#define JJogo 1
#define JPause 2
#define JVitoria 3
#define JDerrota 4
	#Valores para Localização no Programa
	
#Teclas
#define T_P 0x50	#Pause

#define T_W 0x57	# |
#define T_A 0x41	# | - Controle Jogador 2
#define T_S 0x53	# |
#define T_D 0x44	# |



#Variaveis Globais --------------

var BarcoMeio;			# |
var IFundo;				# |
var PonteDir;			# | - 0 para Imagem, 1 Para Mascara
var Barril;			# |
var Bau;				# |
var SprPol;			# | - Mascara / Sprite
var SprFan;			# |
var Vitoria;			# |
var Derrota;			# |
var Botao;			# |
var ImgMenu;				# |
var Jog;		# | - No. Personagem/ Mascara/ Sprite
var Logo;				# |

var Fim = 0;			#Condição de Fim de Jogo
var Atual = 0;			#Local que se está no jogo
var pg;					#contador do Anti-flicker
var tempo = 1;			#tempo usado para spawn de inimigos
var pl = 0;				#usado no spawn de polvos
var Dl = 35; 			#Delay
var L = 0;				#Menu = 0, Jogo = 1 ou Sair
var cMortos = 0;		#Contador de inimigos mortos
var Perdeu = 0;			#Boleano de Bau roubado
var Musica;			#usado como farol se ha musica tocando
var Bt = 0; 			#Botão usado nos Menus


#Programa -----------------------

int main(void){
	
	#Pré Jogo ------------------------
	
	CarregarImagens();
	CarregarMapa();
	
	setbkcolor(RGB(0,50,100));
	
	#Laço do Jogo --------------------
	
	while(!Fim) {
		
		if(pg==1) pg = 2; else pg = 1;
		setactivepage(pg);
		if(L != JPause and L != JVitoria and L != JDerrota){
			cleardevice();
		}
		
		
		
		Inicio();
		Jogo();
		VitDerr();
		
		if(L != JPause){
			setvisualpage(pg);
		}
		else if(pg==1) pg = 2; else pg = 1;
		
		#Controle do Delay O abaixa P almenta
		if(GetKeyState(VK_F2)&0x80 && Dl > 1) 	Dl--;
		if(GetKeyState(VK_F1)&0x80) 			Dl++;
		delay(Dl);
		
	}
	
	
	#Encerramento
	
	closegraph();
	DescarregarImagens();
	return 0;
}


#Funções ------------------------

int Cx(int X) {
	int PxlX;
	PxlX = X * DimP;	
	return PxlX;
}
int Cy(int Y) {
	int PxlY;
	PxlY = Y * DimP;
	return PxlY;
}

void CarregarImagens(){
	int T = 1, a, b, c, d, img, n;
	setactivepage(1);
	#Com Mascara ----------------
	T = 1; a = 0; b = -5 ;c =820 ;d = 730;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("BarcoMeio.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("BarcoMeioM.bmp",a, b, c*T, d*T);
		BarcoMeio[img] = malloc(imagesize(a, b, c*T, d*T - 1));
		getimage(a, b, c*T, d*T - 1, BarcoMeio[img]);
	}
	#--------
	T = 2; a = 0; b = 0 ;c =99 ;d = 99;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("Logo.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("LogoM.bmp",a, b, c*T, d*T);
		Logo[img] = malloc(imagesize(a, b, c*T, d*T));
		getimage(a, b, c*T, d*T, Logo[img]);
	}
	#--------
	T = 1; a = 0; b = 0 ;c =180 ;d = Altu;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("PonteDir.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("PonteDirM.bmp",a, b, c*T, d*T);
		PonteDir[img] = malloc(imagesize(a, b, c*T, d*T));
		getimage(a, b, c*T, d*T, PonteDir[img]);
	}
	#--------
	T = 3; a = 0; b = 0 ;c =284 ;d = 63;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("VitoriaDerrota.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("VitoriaDerrotaM.bmp",a, b, c*T, d*T);
		
		Vitoria[img] = malloc(imagesize(a, b, c*T/2, d*T));
		Derrota[img] = malloc(imagesize(a, b, c*T/2, d*T));
		getimage(a, b, c*T/2, d*T, Vitoria[img]);
		getimage(c*T/2, b, c*T, d*T, Derrota[img]);
		
	}
	#--------
	T = 2; a = 0; b = 0 ;c =128 ;d = 192;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("Push.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("PushM.bmp",a, b, c*T, d*T);
		for(n = 0; n <6; n++) {
			Botao[img][n] = malloc(imagesize(0, 0, 64*T, 64*T));
			getimage((n/3)*c*T/2, (n%3)*d*T/3, (n/3 + 1)*c*T/2, (n%3 +1)*d*T/3, Botao[img][n]);
			}
	}
	#--------
	T = 2; a = 0; b = 0 ;c =16 ;d = 18;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("Barril.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("BarrilM.bmp",a, b, c*T, d*T);
		Barril[img] = malloc(imagesize(a, b, c*T, d*T));
		getimage(a, b, c*T, d*T, Barril[img]);
	}
	#--------
	T = 3; a = 0; b = 0 ;c =11 ;d = 12;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("Bau.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("BauM.bmp",a, b, c*T, d*T);
		Bau[img] = malloc(imagesize(a, b, c*T, d*T));
		getimage(a, b, c*T, d*T, Bau[img]);
	}
	#--------
	
	#Animação -------------------	
	T = 2; a = 0; b = 0 ;c =365 ;d = 30;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("AndarGato1.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("AndarGato1M.bmp", a, b, c*T, d*T);
		for(n = 0; n < 13; n++) {
			Jog[0][img][n] = malloc(imagesize(a, b, c/13*T, (d)*T));
			getimage(56*n, b + 1, 56 * (n + 1), 57, Jog[0][img][n]);
		}
	}
	#--------
	T = 2; a = 0; b = 0 ;c =270 ;d = 45;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("AtaqueGato1.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("AtaqueGato1M.bmp", a, b, c*T, d*T);
		
		for(n = 0; n < 6; n++) {
			Jog[0][img][n +13] = malloc(imagesize(a, b, 45*T, (d)*T));
			getimage(45*T*n, b, 45*T*(n + 1), 45*T , Jog[0][img][n + 13]);
		}
	}
	#--------	
		T = 2; a = 0; b = 0 ;c =365 ;d = 30;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("AndarGato2.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("AndarGato2M.bmp", a, b, c*T, d*T);
		for(n = 0; n < 13; n++) {
			Jog[1][img][n] = malloc(imagesize(a, b, c/13*T, (d)*T));
			getimage(56*n, b, 56 * (n + 1), 57, Jog[1][img][n]);
		}
	}
	#--------
	T = 2; a = 0; b = 0 ;c =270 ;d = 45;
	for(img = 0; img < 2; img++){
		if(img == 0) readimagefile("AtaqueGato2.bmp", a, b, c*T, d*T);
		else if(img == 1) readimagefile("AtaqueGato2M.bmp", a, b, c*T, d*T);
		for(n = 0; n < 6; n++) {
			Jog[1][img][n +13] = malloc(imagesize(a, b, 45*T, (d)*T));
			getimage(45*T*n, b, 45 *T* (n + 1), 45*T, Jog[1][img][n + 13]);
		}
	}	
	T = 2; a = 0; b = 0 ;c =128 ;d = 30;
		for(img = 0; img < 2; img++){
		
			if(img == 0) readimagefile("Polvo.bmp", a, b, c*T, d*T);
			else if(img == 1) readimagefile("PolvoM.bmp", a, b, c*T, d*T);
			
			for(n = 0; n < 4; n++) {
				SprPol[img][n] = malloc(imagesize(a, b, 32*T, (d)*T));
				getimage( 32*T*n, b, 32*T*(n+1) , d*T, SprPol[img][n]);
			}
		}
	#--------
	
	#Sem Mascara ----------------
	T = 1; a = 0; b = 0 ;c =Larg ;d = 754;
	readimagefile("Fundo.bmp", a, b, c*T, d*T);
	IFundo = malloc(imagesize(a, b, c*T, d*T));
	getimage(a, b, c*T, d*T, IFundo);
	#--------
	T = 1; a = 0; b = 0 ;c =717 ;d = 719;
	readimagefile("Menu.bmp", a, b, c*T, d*T);
	ImgMenu = malloc(imagesize(a, b, c*T, d*T));
	getimage(a, b, c*T, d*T, ImgMenu);
		
	}
	

void DescarregarImagens() :
	
	pass

void Inicio() {
	
	pass

void Pause() {
	
	pass

void Jogo() {
	
	Pause();
	
	if (L == JJogo) {
		if(!Musica[1]) {
			mciSendString("open .\\Audio\\Stage1_Theme.mp3 type MPEGVideo alias Fase1", NULL, 0, 0); 
			mciSendString("play Fase1 notify repeat", NULL, 0, 0);	
			Musica[1] = 1;
		}
		
		Fundo();
		PrintMapa(XMapa, YMapa, Atual);
		
		FInimigo(XMapa, YMapa);
		FTesouro(XMapa, YMapa);
		Personagem(XMapa, YMapa);
		Regra();
		
		
		if(GetKeyState(T_P)&0x80) {
			L = JPause;
			mciSendString("pause Fase1", NULL, 0, 0);
			Musica[1] = 0;
		}
	}
	
}

void CarregarMapa() {
	
	
	for(c = 0; c < 4; c++){
		#reseta musica
		Musica[c] = 0;
	}
	
	
	for(c = 0; c <2; c++) {	
		Jogador[c].y = DimP;
		Jogador[c].dir = 0;
		Jogador[c].Ataque = 13;
		Jogador[c].Pose = 0;
	}
	Jogador[0].Status = 1;
	Jogador[1].x = 9*DimP;
	Jogador[0].x = DimP;
	
	f[0] = Cy(1); f[1] = Cy(3);
	f[2] = Cy(6); f[3] = Cy(8); 
	for (c = 0; c < Plv; c++) {
		
		Polvo[c].Status = 0;
		Polvo[c].Pose = 0;
		Polvo[c].Fileira = rand()%4;
		Polvo[c].y = f[Polvo[c].Fileira];

	}
	for (c = 0; c < Plv; c++) {
		
		Fantasma[c].Status = 0;
		Fantasma[c].Pose = 0;
		Fantasma[c].Fileira = rand()%4;
		Fantasma[c].y = f[Fantasma[c].Fileira];

	}
	
	
	for(c = 0; c < NFases; c++){
		t = 0;
		for(xm = 0; xm < TamanhoX; xm++) {
			for(ym = 0; ym < TamanhoY; ym++) {
				
				Onda[c].Mapa[xm][ym] = 0;
				
				Tesouro[t].Status = 0;
				
				if (xm == 0 || xm == TamanhoX - 1 || ym == 0 || ym == TamanhoY - 1) {
					Onda[c].Mapa[xm][ym] = 1;
				}
				
				if (xm == 5 && (ym == 1 || ym == 3 || ym == 6 || ym == 8)) {
					
					Tesouro[t].x = Cx(xm);
					Tesouro[t].y = Cy(ym);
					Tesouro[t].Status = 1;
					t++;
					
				}
				
				#Mapa 1
				if (c == 0)
					if( (xm == 4 or xm == 7) and ym == 1 or
						xm == 5 and ym == 5 or
						xm == 5 and ym == 5 or
						xm == 1 and ym == 6 or
						xm == 3 and ym == 7 or
						xm == 9 and ym == 8 ) {
							
						Onda[c].Mapa[xm][ym] = 1;
					}
				#Mapa 2
				if (c == 1)
					if(	xm == 4 and ym == 2 or
						xm == 1 and ym == 5 or
						xm == 5 and (ym == 4 or ym == 5) or
						xm == 6 and ym == 7 or
						xm == 9 and ym == 4 ) {
							
						Onda[c].Mapa[xm][ym] = 1;
					}
				
				#Mapa 3
				if (c == 2) {
					
					if(	xm == 2 and ym == 4 or
						xm == 3 and(ym == 6 or ym == 8) or
						xm == 4 and ym == 1 or
						xm == 6 and ym == 8 or
						xm == 7 and(ym == 1 or ym == 3) or
						xm == 8 and ym == 6 or
						xm == 9 and ym == 4	) {
							
						Onda[c].Mapa[xm][ym] = 1;
					}
					
				}
				
				#Mapa 4
				if (c == 3) {
					
					if(	(xm == 6 or xm ==4) and ym == 1 or
						xm == 2 and ym == 2 or
						xm == 9 and ym == 3 or
						xm == 8 and ym == 5 or
						xm == 1 and ym == 6 or
						(xm == 3 or xm == 7) and ym == 7	) {
							
						Onda[c].Mapa[xm][ym] = 1;
					}
				}
			}
		}
	}	
}

void Fundo() {
		putimage(0, 0, IFundo, COPY_PUT);
		
		putimage(145,-5,BarcoMeio[1], OR_PUT);
		putimage(145,-5,BarcoMeio[0], AND_PUT);
		
		putimage(900, 0, PonteDir[1], OR_PUT);
		putimage(900, 0, PonteDir[0], AND_PUT);
}

void PrintMapa(int X, int Y, int N) {
	int i, j, mx, my, bau;
	
	for(i = 0; i < TamanhoX; i++) {
		for(j = 0; j < TamanhoY; j++) {
			if(Onda[N].Mapa[i][j] == 1) {

				mx = 10; my = 10;
				putimage(X + mx + Cx(i), Y + my + Cy(j), Barril[1], OR_PUT);
				putimage(X + mx + Cx(i), Y + my + Cy(j), Barril[0], AND_PUT);
				
			}
		}
	}
}

void FTesouro(int ftX, int ftY) {
	int mx, my, bau;
	
	for(bau = 0; bau < 4; bau++) {
		
		mx = 10; my = 17;
		if(Tesouro[bau].Status != 0) {
			
			#Desenha
			putimage(ftX + mx + Tesouro[bau].x, ftY + my + Tesouro[bau].y, Bau[1], OR_PUT);
			putimage(ftX + mx + Tesouro[bau].x, ftY + my + Tesouro[bau].y, Bau[0], AND_PUT);
			
			if (Tesouro[bau].Status == 2) Tesouro[bau].x-=15;
			if (Tesouro[bau].Status == 3) Tesouro[bau].x+=15;
		}
		Tesouro[bau].Status = 1;
		if(Tesouro[bau].x > Cx(13) || Tesouro[bau].x < Cx(-3)) Perdeu = 1;
	}
	
	
	
	
}

void Personagem(int psX, int psY) {

	int mx = 0, my = 0, q;
	
	for (q = 0; q < 2; q++) {
		if(Jogador[q].Status != 0) {
			
				if(Jogador[q].Pose%2 == 1) {
					sndPlaySound(".\\Audio\\Char_Move.wav", SND_ASYNC);	
				}
				#Desenha
				#Anda Pose de 0 a 12
				if(Jogador[q].Status == 1){
					putimage(psX + mx + Jogador[q].x, psY + my + Jogador[q].y, Jog[q][1][Jogador[q].Pose], OR_PUT);
					putimage(psX + mx + Jogador[q].x, psY + my + Jogador[q].y, Jog[q][0][Jogador[q].Pose], AND_PUT);
				}
				#Ataca Spt de 13 a 18
				if(Jogador[q].Status == 2){
					if(Jogador[q].Ataque >= 19) Jogador[q].Ataque = 13;
					putimage(psX - 15 + Jogador[q].x, psY -15 + Jogador[q].y, Jog[q][1][Jogador[q].Ataque], OR_PUT);
					putimage(psX - 15 + Jogador[q].x, psY -15 + Jogador[q].y, Jog[q][0][Jogador[q].Ataque], AND_PUT);
					Jogador[q].Ataque++;
					if (Jogador[q].Ataque == 19) Jogador[q].Status = 1;
				}
			
			
			#Movimenta
			if(Jogador[q].dir >= 0 && Jogador[q].dir <= 4) Jogador[q].dir = Jogador[q].dir; else Jogador[q].dir = 0;
			if(Jogador[q].Pose >= 0 && Jogador[q].Pose <= 21) Jogador[q].Pose = Jogador[q].Pose; else Jogador[q].Pose = 0;
			Jogador[q].coordX = (Jogador[q].x + Jogador[q].x%DimP)/DimP;
			Jogador[q].coordY = (Jogador[q].y + Jogador[q].y%DimP)/DimP;
				
			if(q == 0) {
				if(GetKeyState(VK_UP)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 1) {
					Jogador[q].dir = 1;
					if (Jogador[q].dir == 1 && Onda[Atual].Mapa[Jogador[q].coordX][Jogador[q].coordY - 1] != 1){
						Jogador[q].y-=(DimP/2);
						if(Jogador[q].Pose >= 7 || Jogador[q].Pose < 4) Jogador[q].Pose = 4;
						else Jogador[q].Pose++;
					}
					else {
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					}
				}
				if(GetKeyState(VK_LEFT)&0x80 && Jogador[q].dir == 0|| Jogador[q].dir == 2) {
					Jogador[q].dir = 2;
					if (Jogador[q].dir == 2 && Onda[Atual].Mapa[Jogador[0].coordX - 1][Jogador[0].coordY] != 1){
						Jogador[0].x-=(DimP/2);
						if(Jogador[0].Pose == 12) Jogador[0].Pose = 11;
						else Jogador[0].Pose = 12;
					}
					else {
						Jogador[q].dir = 0;
						Jogador[0].Pose = 0;
					}
				}
				Jogador[0].coordX = (Jogador[0].x )/DimP ;
				Jogador[0].coordY = (Jogador[0].y )/DimP ;
				if(GetKeyState(VK_DOWN)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 3) {
					Jogador[q].dir = 3;
					if (Jogador[q].dir == 3 && Onda[Atual].Mapa[Jogador[0].coordX][Jogador[0].coordY + 1] != 1){
						Jogador[0].y+=(DimP/2);
						
						if(Jogador[0].Pose >= 3) Jogador[0].Pose = 0;
						else Jogador[0].Pose++;
					}
					else {
						Jogador[q].dir = 0;
						Jogador[0].Pose = 0;
					}
				}
				if(GetKeyState(VK_RIGHT)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 4) {
					Jogador[q].dir = 4;
					if (Jogador[q].dir == 4 && Onda[Atual].Mapa[Jogador[0].coordX + 1][Jogador[q].coordY] != 1){
						Jogador[q].x+=(DimP/2);
						
						if(Jogador[q].Pose == 10) Jogador[0].Pose = 9;
						else Jogador[q].Pose = 10; 
					}
					else {
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					}
				}
			}
			
			if(q == 1) {
				#Cima
				if(GetKeyState(T_W)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 1) {
					Jogador[q].dir = 1;
					if (Jogador[q].dir == 1 && Onda[Atual].Mapa[Jogador[q].coordX][Jogador[q].coordY - 1] != 1){
						Jogador[q].y-=(DimP/2);
						if(Jogador[q].Pose >= 7 || Jogador[q].Pose < 4) Jogador[q].Pose = 4;
						else Jogador[q].Pose++;
					}
					else {
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					}
				}
				#Esquerda
				if(GetKeyState(T_A)&0x80 && Jogador[q].dir == 0|| Jogador[q].dir == 2) {
					Jogador[q].dir = 2;
					if (Jogador[q].dir == 2 && Onda[Atual].Mapa[Jogador[q].coordX - 1][Jogador[q].coordY] != 1){
						Jogador[q].x-=(DimP/2);
						if(Jogador[q].Pose == 12) {
							Jogador[q].Pose = 11;
							 
						}
						else Jogador[q].Pose = 12;
					}
					else {
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					}
				}
				Jogador[q].coordX = (Jogador[q].x )/DimP ;
				Jogador[q].coordY = (Jogador[q].y )/DimP ;
				#Baixo
				if(GetKeyState(T_S)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 3) {
					Jogador[q].dir = 3;
					if (Jogador[q].dir == 3 && Onda[Atual].Mapa[Jogador[q].coordX][Jogador[q].coordY + 1] != 1){
						Jogador[q].y+=(DimP/2);
						
						if(Jogador[q].Pose >= 3) Jogador[q].Pose = 0;
						else Jogador[q].Pose++;
					}
					else {
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					}
				}
				#Direita
				if(GetKeyState(T_D)&0x80 && Jogador[q].dir == 0 || Jogador[q].dir == 4) {
					Jogador[q].dir = 4;
					if (Jogador[q].dir == 4 && Onda[Atual].Mapa[Jogador[q].coordX + 1][Jogador[q].coordY] != 1){
						Jogador[q].x+=(DimP/2);
						
						if(Jogador[q].Pose == 10) Jogador[q].Pose = 9;
						else Jogador[q].Pose = 10; 
					}
					else {
						Jogador[q].dir = 0;
						Jogador[q].Pose = 0;
					}
				}
			}
		}
		else if(GetKeyState(T_W)&0x80 || GetKeyState(T_A)&0x80 || 
		GetKeyState(T_S)&0x80 || GetKeyState(T_D)&0x80) {
			Jogador[q].Status = 1;
		}
	}
}
	

void FInimigo(int inX, int inY) {
	
	int mx = 0, my = 0, quan, J, spawn = 1;
	
	
	for (quan = 0; quan < Plv; quan++) {
		if(Polvo[quan].Status != 0) {
				
			#Desenha
			putimage(inX + mx + Polvo[quan].x, inY + my + Polvo[quan].y, SprPol[1][Polvo[quan].Pose], OR_PUT);
			putimage(inX + mx + Polvo[quan].x, inY + my + Polvo[quan].y, SprPol[0][Polvo[quan].Pose], AND_PUT);
		
			if(Polvo[quan].Status == 2) {
				Polvo[quan].x-= 15;
				if(Polvo[quan].Pose == 3) Polvo[quan].Pose = 2;
				else Polvo[quan].Pose  = 3;
			}
			if(Polvo[quan].Status == 3) {
				Polvo[quan].x+= 15;
				if(Polvo[quan].Pose == 1) Polvo[quan].Pose = 0;
				else Polvo[quan].Pose  = 1;
			}
			
			if(Tesouro[Polvo[quan].Fileira].Status == 1){	
				if(Polvo[quan].Status == 2){
					if(	Tesouro[Polvo[quan].Fileira].x - DimP < Polvo[quan].x  &&
						Polvo[quan].x < Tesouro[Polvo[quan].Fileira].x + DimP/8 ){
						
						Tesouro[Polvo[quan].Fileira].x = Polvo[quan].x +10;
						
						Tesouro[Polvo[quan].Fileira].Status = 2;
						
					}
				}
				if(Polvo[quan].Status == 3){
					if(Tesouro[Polvo[quan].Fileira].x - DimP/8< Polvo[quan].x  &&
					Polvo[quan].x < Tesouro[Polvo[quan].Fileira].x + DimP ){
						
						Tesouro[Polvo[quan].Fileira].x = Polvo[quan].x ;
						
						Tesouro[Polvo[quan].Fileira].Status = 3;
						
						
					}
				}
				
			}
			for(J = 0; J < 2; J++){
				if(Jogador[J].Status !=0){
					if(Polvo[quan].x < Jogador[J].x + 4*DimP/3 &&
					Jogador[J].x - 4*DimP/3 < Polvo[quan].x) {
						if(Polvo[quan].y < Jogador[J].y + 4*DimP/3 &&
						Jogador[J].y - 4*DimP/3 < Polvo[quan].y) {
							Polvo[quan].Status = 0;
							cMortos++;
							Jogador[J].Status = 2;
							sndPlaySound(".\\Audio\\Char_Attack.wav", SND_ASYNC);
							delay(60);
						}
					}
				}
				
			}
		}

	}
	
	if(tempo == 500) tempo = 2; else tempo++;
	
	if(Jogador[1].Status == 1) spawn = 2;
	
	if(tempo%(50/spawn) == 0) {
		if(pl == Plv) pl = 0; else pl++;
		Polvo[pl].Status = rand()%2 + 2;
		
		if(Polvo[pl].Status == 2) {
			Polvo[pl].x = Cx(15); 
			Polvo[pl].Pose = 1;
		}
		else if(Polvo[pl].Status == 3) {
			Polvo[pl].x = Cx(-5);
			Polvo[pl].Pose = 3; 
		}
	} 
	
}

void Regra() {
	int Rg, meta = 40;
	if(Jogador[1].Status == 0) meta = 20;
	
	if(cMortos >= meta) {
		L = JVitoria;
		if(Atual >= NFases - 1) Atual = 0; else Atual++;
		CarregarMapa();
	}
		
	for(Rg = 0; Rg < 4; Rg++) {
		if(Tesouro[Rg].Status == 0) {
			Perdeu = 1;
		}		
	}
	if(Perdeu == 1) {
		L = JDerrota;
		Atual = 0;
	}
}

void VitDerr() {

	if(L == JVitoria) {
		
			putimage(Larg/3, Altu/3, Vitoria[1], OR_PUT);
			putimage(Larg/3, Altu/3, Vitoria[0], AND_PUT);
		
		if(!Musica[3]) {
			mciSendString("open .\\Audio\\Winner_Theme.mp3 type MPEGVideo alias Win", NULL, 0, 0);
			mciSendString("play Win", NULL, 0, 0); 
			Musica[3] = 1;
		}
		
		if(GetKeyState(VK_RETURN)&0x80) {
			if(Atual == 0) L = JInicio;
			else L = JJogo;
			mciSendString("close Win", NULL, 0, 0);
			Musica[3] = 0;
			sndPlaySound(".\\Audio\\Menu_Select.wav", SND_ASYNC);
			delay(200);
		}
	}
	if(L == JDerrota) {
	
			putimage(Larg/3, Altu/3, Derrota[1], OR_PUT);
			putimage(Larg/3, Altu/3, Derrota[0], AND_PUT);
		
		if(!Musica[4]) {
			mciSendString("open .\\Audio\\Loser_Theme.mp3 type MPEGVideo alias Lose", NULL, 0, 0);
			mciSendString("play Lose", NULL, 0, 0); 
			Musica[4] = 1;
		}
		
		if(GetKeyState(VK_RETURN)&0x80) {
			L = JInicio;
			mciSendString("close Lose", NULL, 0, 0); 
			Musica[4] =0;
			sndPlaySound(".\\Audio\\Menu_Select.wav", SND_ASYNC);
			delay(200);
		}
	}
}

void BDJogo () {
	sqlite3 *db;
	char *err_msg = 0;
	int rc = sqlite3_open("dbSeaCats.db", &db);
	
	if (rc != SQLITE_OK) {
		fprintf(stderr, "Cannot open database: %s\n", sqlite3_errmsg(db));
		sqlite3_close(db);
		
		return 1;
	}
	
	char *sql = "Insert into Jogador values ("+ID+","NumFase","c_Mortos","Data_Inicio","Data_Final","Qtd_BauMovido");";
	
	rc = sqlite3_exec(db, sql, 0, 0, &err_msg);
	
	if (rc != SQLITE_OK) {
		fprinf(stderr, "SQL error: %s\n", err_msg);
		
		sqlite3_free(err_msg);
		sqlite3_close(db);
		
		return 1;
	}
	
	sqlite3_close(db);
	
	return 0;
}
