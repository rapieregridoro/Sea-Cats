extends Node

var IndexInicio = preload("res://Scenes/Inicio.tscn")
var Inicio = IndexInicio.instance()

func _ready():
	add_child(Inicio, false)
	

#func _process(delta):
#	pass


