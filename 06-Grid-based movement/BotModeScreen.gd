extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn")

func _on_Easy_Bot_pressed():
	variableLAN.mode = 2
	variableLAN.botdifficulty = 1
	get_tree().change_scene("res://LAN.tscn")

func _on_Medium_Bot_pressed():
	variableLAN.mode = 2
	variableLAN.botdifficulty = 2
	get_tree().change_scene("res://LAN.tscn")

func _on_Hard_Bot_pressed():
	variableLAN.mode = 2
	variableLAN.botdifficulty = 3
	get_tree().change_scene("res://LAN.tscn")
