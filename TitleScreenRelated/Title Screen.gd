extends Node


func _ready():
	$Menu/CenterRow/Buttons/Play.grab_focus()

func _physics_process(delta):
	if $Menu/CenterRow/Buttons/Play.is_hovered() == true:
		$Menu/CenterRow/Buttons/Play.grab_focus()
	if $Menu/CenterRow/Buttons/Options.is_hovered() == true:
		$Menu/CenterRow/Buttons/Options.grab_focus()

func _on_Play_pressed():
	get_tree().change_scene("Game.tscn")
