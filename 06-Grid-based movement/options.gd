extends Node

# Declare member variables here. Examples:
# var a = 2
onready var check = true
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Mute_Button_pressed():
	AudioServer.set_bus_mute(0,check)
	check = !check # Replace with function body.


func _on_TextureButton_pressed():
	get_tree().change_scene("res://TitleScreenRelated/TitleScreen.tscn") # Replace with function body.
