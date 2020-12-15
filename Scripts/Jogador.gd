extends Node2D

export(int, 1, 2) var Jogador = 1
var dirbuffer := Vector2(0,0)

var indopara := Vector2(0,0)
var arena = []

func _ready():
	
	$Gato_1.visible = false
	$Gato_2.visible = false
	
	arena = SE_Global.Onda[SE_Global.Atual]
	
	pos_original = position
	pos_final = position
	

func _physics_process(delta):
	
	animation()
	
	if SE_Global.direcao.x * SE_Global.direcao.y == 0:
		dirbuffer = SE_Global.direcao
	movimento_em_grade()


#delta posição
var pos_original : Vector2
var pos_final : Vector2

func movimento_em_grade():
	#movimenta em Grade
	if (position - pos_final).length_squared() < 5:
		position = pos_final
		pos_original = position
		pos_final = position + dirbuffer * 56
	
	position = position + (pos_final - pos_original) * 0.1
	



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
	



func moviment():
#
#	#excluindo a possibilidade de: diagonais
#	if SE_Global.direcao.x * SE_Global.direcao.y == 0:
#		dirbuffer = SE_Global.direcao
#
#	if (position - pos_final).length_squared() < 5:
#
#		#ao final teleporta para a posição alvo
#		position = pos_final
#
#		#movimentar entre 
#		#pos_buffer = position
#		#pos_alvo = pos_buffer + dirbuffer * 56
#		pos_final = position + dirbuffer * 56
#
#		#para a animação
#		indopara = dirbuffer
#
#	else:
#		position = position.move_toward((pos_final), 5)
#
#
#	#outros metodos que eram promissores:
#	#	move_and_slide((pos_alvo - pos_buffer) * 5)
#	#	position = position + (pos_alvo - pos_buffer)*delta
#
	pass
#	

