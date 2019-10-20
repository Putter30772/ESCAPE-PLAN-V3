extends Node

# Declare member variables here. Examples:
onready var check = true
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer2/PlayButton.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer2/PlayButton.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer2/PlayButton.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer2/OptionsButton.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer2/OptionsButton.grab_focus()

func _on_PlayButton_pressed():
	get_tree().change_scene("res://TitleScreenRelated/Title Screen.tscn") # Replace with function body.

func _on_CheckButton_pressed():
	AudioServer.set_bus_mute(0,check)
	check = !check # Replace with function body.
