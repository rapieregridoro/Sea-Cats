extends Node

"""Grupo --------------------------

Marcelo Hiroaki Hisatomi
Rodrigo Pereira Caetano da Silva
Virginia Cardoso de Toledo

"""

#Constantes
#Tela
const Largura = 1080
const Altura = 720

#Coordenada
const TCelula = Vector2(56, 56)  #TCelula no original

#Origem do Mapa
const XMapa = 246
const YMapa = 123

#Colunas e Linhas
const TamanhoX = 11
const TamanhoY = 10

#Numero de Fases
const NFases = 4

#Numero de Inimigos
const Plv = 10
const Fnt = 10

#Menus
#Valores para Localização do Programa
const JInicio = 0
const JJogo = 1
const JPause = 2
const JVitoria = 3
const JDerrota = 4

#Teclas
const T_P = 0x50
const T_W = 0x57
const T_A = 0x41
const T_S = 0x53
const T_D = 0x44

#Input
var direcao : Vector2

var Fim = 0
#Condição de Fim de Jogo
var Atual = 0
#Local que se está no jogo
var pg
#contador do Anti-flicker, não é mais necessário
var tempo = 1
#tempo usado para spawn de inimigos
var pl = 0
#usado no spawn de polvos
var Dl = 35
#Delay
var L = 0
#Menu = 0, Jogo = 1 ou Sair
var InimigosMortos = 0 #original cMortos
#Contador de inimigos mortos
var Perdeu = 0
#Boleano de Bau roubado
var Musica = [[],[],[],[]]
#usado como farol se ha musica tocando
var Bt = 0
#Botão usado nos Menus

var Onda = []


func _ready():
	
	CarregarMapa()
	

func _input(event):
	
	direcao = Direction()
	

func _process(delta):
	
	pass
	



#Chamada das Funções ------------
	#aparecem após o Programa na mesma ordem
	#Funciona como um Indice para entender oque faz cada função

func Cx(X):
	var PxlX
	PxlX = X * TCelula
	return PxlX
	
func Cy(Y):
	var PxlY
	PxlY = Y * TCelula
	return PxlY
	
#converte posição no mapa em posição em pixels, para uso de coordenadas 
#X = 0 ~ TamanhoX, Y = 0 ~ TamanhoY, fora desses valores são coordenadas fora da area esperada

func Direction() -> Vector2:
	var direction : Vector2
	
	direction.x = ( int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")) )
	direction.y = ( int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")) )
	
	return direction

func CarregarImagens():
	
	pass
	
#Carrega Imagens que seram utilizadas no jogo
#T é a proporção da Imagem, 1 para normal
#'a' 'b' 'c' e 'd' são coordenadas do tamanho da Imagem
#img é usado pra selecionar entre carregar imagem e mascara

func DescarregarImagens():
	
	pass
	
#Limpa as imagens da memória

func Inicio():
	
	pass
	
#Menu de Inicio do Jogo

func Pause():
	
	pass
	
#Pausa o Jogo

func Jogo():
	
	pass
	
#Jogo

func CarregarMapa():
	
	
	
	var t
	var f = []
	f.resize(4)
	
	InimigosMortos = 0;
	Perdeu = 0;
	
	
	
	
	Onda.resize(NFases)
	
	for contador_1 in range(Onda.size()):
		Onda[contador_1] = []
		Onda[contador_1].resize(TamanhoX)
		for contador_2 in range(Onda[contador_1].size()):
			Onda[contador_1][contador_2] = []
			Onda[contador_1][contador_2].resize(TamanhoY)
			
	
	for c in range(Onda.size()):
		t = 0
		for xm in range(Onda[c].size()):
			for ym in range(Onda[c][xm].size()):
				
				Onda[c][xm][ym] = 0
				
				if xm == 0 || xm == TamanhoX - 1 || ym == 0 || ym == TamanhoY - 1:
					Onda[c][xm][ym] = 1
					
				
				#Mapa 1
				if (c == 0):
					if( (xm == 4 or xm == 7) and ym == 1 or
						xm == 5 and ym == 5 or
						xm == 5 and ym == 5 or
						xm == 1 and ym == 6 or
						xm == 3 and ym == 7 or
						xm == 9 and ym == 8 ) :
							
							Onda[c][xm][ym] = 1
						
					
				
				#Mapa 2
				if (c == 1):
					if( xm == 4 and ym == 2 or
						xm == 1 and ym == 5 or
						xm == 5 and (ym == 4 or ym == 5) or
						xm == 6 and ym == 7 or
						xm == 9 and ym == 4 ):
							
							Onda[c][xm][ym] = 1
					
				
				#Mapa 3
				if (c == 2):
					
					if( xm == 2 and ym == 4 or
						xm == 3 and(ym == 6 or ym == 8) or
						xm == 4 and ym == 1 or
						xm == 6 and ym == 8 or
						xm == 7 and(ym == 1 or ym == 3) or
						xm == 8 and ym == 6 or
						xm == 9 and ym == 4 ):
							
							Onda[c][xm][ym] = 1;
						
					
				
				#Mapa 4
				if (c == 3):
					
					if( (xm == 6 or xm ==4) and ym == 1 or
						xm == 2 and ym == 2 or
						xm == 9 and ym == 3 or
						xm == 8 and ym == 5 or
						xm == 1 and ym == 6 or
						(xm == 3 or xm == 7) and ym == 7 ):
							
							Onda[c][xm][ym] = 1;
						
					
				
			
		
	
#Usado para carregar a posição dos barris
#Usado para carregar posição inicial dos Baus
#Usado para caregar a Posição inicial do(s) jogador(es)

func Fundo():
	
	pass
	
#Printa o fundo da Fase de Jogo, não é nessessário

func PrintMapa(X, Y, N):
	
	
	pass
	
#Desenha os Barris do Barco de acordo com a Onda
#Contem a Função FTesouro
#Contem a Função Personagem

func FTesouro( X, Y):
	
	pass
	
#Controla os Baus no Mapa


func Personagem( psX,  pxY):
	
	pass
	
#Controla o(s) Personagem(s)

func FInimigo( inX,  inY):
	
	pass
	
#Controla os inimigos

func Regra():
	
	pass
	
#Condição de Vitória e Derrota

func VitDerr():
	
	pass
	
#Tela de Derrota e Vitória

func BDJogo():
	
	pass
	
#Gerenciamento do banco de dados, Score do Jogo



