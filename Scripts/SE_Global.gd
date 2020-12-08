extends Node


#Constantes
#Tela
const Larg = 1080
const Altu = 720

#Coordenada
const DimP = 56

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

var Person = { 
	"x":null, "y":null,
	"coordX":null, "coordY":null,
	"Status":null,
	"Pose":null,
	"dir":null,
	"Ataque":null
	}

var Inimigo = {
	"x":null, "y":null,
	"Status":null,
	"Pose":null,
	"Fileira":null
	}

var Cofre = {
	"x":null,
	"y":null,
	"Status":null
	}

var Fim = 0
var Atual = 0
var pg
var tempo = 1
var pl = 0
var Dl = 35
var L = 0
var cMortos = 0
var Perdeu = 0
var Musica = [[],[],[],[]]
var Bt = 0

#Objetos declaradosem cpp
#Fase Onda[NFases]
#Person Jogador[2]
#Cofre Tesouro[4]

#Inimigo Polvo[Plv]
#Inimigo Fantasma[Fnt]

#Chamada das Funções ------------
	#aparecem após o Programa na mesma ordem
	#Funciona como um Indice para entender oque faz cada função

func Cx(X):
	var PxlX
	PxlX = X * DimP
	return PxlX
	

func Cy(Y):
	var PxlY
	PxlY = Y * DimP
	return PxlY
	

#converte posição no mapa em posição em pixels, para uso de coordenadas 
#X = 0 ~ TamanhoX, Y = 0 ~ TamanhoY, fora desses valores são coordenadas fora da area esperada

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
	
	pass
	#Usado para carregar a posição dos barris
	#Usado para carregar posição inicial dos Baus
	#Usado para caregar a Posição inicial do(s) jogador(es)

func Fundo():
	
	pass

#Printa o fundo da Fase de Jogo

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
	#Gerenciamento do banco de dados


func _ready():
	print("entrou")
	
	var Onda = []
	Onda.resize(NFases)
	
	for contador_1 in range(Onda.size()):
		Onda[contador_1] = []
		Onda[contador_1].resize(TamanhoX)
		for contador_2 in range(Onda[contador_1].size()):
			Onda[contador_1][contador_2] = []
			Onda[contador_1][contador_2].resize(TamanhoY)
			
	
	for contador_1 in range(Onda[0].size()):
		
		print(Onda[0][contador_1]," ",contador_1)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
