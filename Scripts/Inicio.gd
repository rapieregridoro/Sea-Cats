extends Control


#Menu de Inicial do Jogo Sea Cats

"""
Aqui Falta O Botão inicial começar o jogo 
O Botão multiplayer começar o jogo com dois jogadores
E Talvez colocar mais ultilidade para os outros botões feitos
"""




func _ready():
	
	SE_Global.get_node("Menu_Theme").play()
	
	$Jogar.grab_focus()
	$Jogar.connect("focus_entered",$".","_on_Jogar_focus_entered")
	
	ImgMenu_ready()
	
	
	pass # Replace with function body.

func _process(_delta):
	
	$Jogar/Sprite.visible = $Jogar.is_hovered() or $Jogar.is_hovered()
	$Multiplayer/Sprite.visible = $Multiplayer.is_hovered()
	$Sair/Sprite.visible = $Sair.is_hovered()
	

func ImgMenu_ready():
	#estado inicial do ImgMenu
	$ImgMenu.expand = true
	$ImgMenu.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	$ImgMenu.rect_size = Vector2(720,720)
	$ImgMenu.rect_position = Vector2(361,0)
	

func foco_no_botao():
	#aparece e desaparece com a imagem ao lado dos botões quando focados
	
	$Jogar/Sprite.visible = $Jogar.is_hovered()
	$Multiplayer/Sprite.visible = $Multiplayer.is_hovered()
	$Sair/Sprite.visible = $Sair.is_hovered()
	

#func logoapago():
#	var L
#	if(L == JInicio):
#		#if(!Musica[0]):
#		#	mciSendString("play Menu notify repeat", NULL, 0, 0);
#		#	Musica[0] = 1;
#		
#		
#		if(GetKeyState(VK_RETURN)&0x80) :
#			if( Bt == 0 or Bt == 1) :
#				L = JJogo;
#				Jogador[1].Status = 0;
#				CarregarMapa();
#				mciSendString("close Menu", NULL, 0, 0);
#				Musica[0] = 0;
#				sndPlaySound(".\\Audio\\Menu_Select.wav", SND_ASYNC);
#				if (Bt == 1):
#					Jogador[1].Status = 1;
#
#	pass


func _on_Jogar_focus_entered():
	#conecta via codigo para não tocar antes de começar o jogo
	SE_Global.get_node("Menu_Troca").play()

func _on_Jogar_mouse_entered():
	SE_Global.get_node("Menu_Troca").play()

func _on_Jogar_pressed():
	SE_Global.get_node("Menu_Select").play()
	


func _on_Multiplayer_focus_entered():
	SE_Global.get_node("Menu_Troca").play()

func _on_Multiplayer_mouse_entered():
	SE_Global.get_node("Menu_Troca").play()

func _on_Multiplayer_pressed():
	SE_Global.get_node("Menu_Select").play()
	


func _on_Sair_focus_entered():
	SE_Global.get_node("Menu_Troca").play()

func _on_Sair_mouse_entered():
	SE_Global.get_node("Menu_Troca").play()

func _on_Sair_pressed():
	SE_Global.get_node("Menu_Select").play()
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().quit()


