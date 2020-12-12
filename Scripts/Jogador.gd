extends KinematicBody2D

export(int, 1, 2) var Jogador = 2
var dirbuffer := Vector2(0,0)
var indopara := Vector2(0,0)
var arena = []

func _ready():
	
	$Gato_1.visible = false
	$Gato_1.visible = false
	arena = SE_Global.Onda[SE_Global.Atual]
	

func _physics_process(delta):
	
	animation()
	moviment(delta)
	


func moviment(delta):
	
	#excluindo a possibilidade de: diagonais
	if SE_Global.direcao.x * SE_Global.direcao.y == 0:
		dirbuffer = SE_Global.direcao
	
	#se parado recebe intenção
	if indopara == Vector2(0,0):
		indopara = dirbuffer
	#se não, continua andando
	else:
		position = position.move_toward(position + indopara,728*delta)
		#position += indopara*200*delta
	
	if indopara == Vector2(0,1) and position.y > 200:
		indopara = Vector2(0,0)
		
	
	print(position, position.snapped(Vector2(28,28)))




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
	


