extends Node

var connected_player = null
var ready = false
var grid = []
var playername = ""

func _ready():
	pass # Replace with function body.

func set_id(id):
	name = str(id)