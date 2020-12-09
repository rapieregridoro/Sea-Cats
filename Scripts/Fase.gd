extends TileMap




func _ready():
	cell_size = SE_Global.TCelula
	PrintMapa(3)
	



func PrintMapa(var N):
	
	var mx
	var my
	var bau
	
	for i in range(SE_Global.Onda[N].size()):
		for j in range(SE_Global.Onda[N][i].size()):
			
			if SE_Global.Onda[N][i][j] == 1:
				mx = 10
				my = 10
				set_cell(i, j, 0)
				
			
			
		
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
