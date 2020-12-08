extends Control

"""

falta ser chamado quando pausa
falta os botões fazerem algo
Voltar é para continuar o jogo
Sair é para encerrar o jogo ou voltar ao Inicio
talvez seja bom outros textos nos botões

"""

func _ready():
	pass 

#func _process(delta):
#	pass


func _on_Voltar_focus_entered():
	SE_Global.get_node("Menu_Troca").play()

func _on_Voltar_mouse_entered():
	SE_Global.get_node("Menu_Troca").play()

func _on_Voltar_pressed():
	pass # Replace with function body.


func _on_Sair_focus_entered():
	SE_Global.get_node("Menu_Troca").play()

func _on_Sair_mouse_entered():
	SE_Global.get_node("Menu_Troca").play()

func _on_Sair_pressed():
	pass # Replace with function body.
