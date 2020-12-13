extends KinematicBody2D

export(int, 1, 2) var Jogador = 1
var dirbuffer := Vector2(0,0)
var indopara := Vector2(0,0)
var arena = []

func _ready():
	
	$Gato_1.visible = false
	$Gato_2.visible = false
	
	arena = SE_Global.Onda[SE_Global.Atual]
	
	pos_buffer = position
	pos_alvo = position
	

func _physics_process(delta):
	
	animation()
	moviment(delta)
	


func moviment(delta):
	
	#excluindo a possibilidade de: diagonais
	if SE_Global.direcao.x * SE_Global.direcao.y == 0:
		dirbuffer = SE_Global.direcao
	
	if (position - pos_alvo).length_squared() < 5:
		position = pos_alvo
		pos_buffer = position
		pos_alvo = pos_buffer + dirbuffer * 56
		indopara = dirbuffer
	
	
	print((position - pos_alvo).length_squared())
	move_and_slide((pos_alvo - pos_buffer) * 5)
	#position = position + (pos_alvo - pos_buffer)*delta
	
	print(dirbuffer)
	
	pass

var pos_buffer : Vector2
var pos_alvo : Vector2

func animation():
	
	get_node(String("Gato_" + String(Jogador) ) ).visible = true
	
	if indopara == Vector2(0,0):
		get_node(String("Gato_" + String(Jogador) ) ).animation = "Parado"
	if indopara == Vector2(0,-1):
		get_node(String("Gato_" + String(Jogador) ) ).animation = "AndarCima"
	if indopara == Vector2(-1,0):
		get_node(String("Gato_" + String(Jogador) ) ).animation = "AndarEsquerda"
	if indopara == Vector2(0,1):
		get_node(String("Gato_" + String(Jogador) ) ).animation = "AndarBaixo"
	if indopara == Vector2(1,0):
		get_node(String("Gato_" + String(Jogador) ) ).animation = "AndarDireita"
	


