extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
var cursor100_light = preload("res://TitleScreenRelated/cursor100_light.png")
var logo_light = preload("res://TitleScreenRelated/newlogo_light.png")
var cursor100 = preload("res://TitleScreenRelated/cursor100.png")
var logo = preload("res://TitleScreenRelated/newlogo.png")

func _ready():
	if !MusicController._player.is_playing() :
		MusicController.play("res://SoundEffects/274787__setuniman__intro-1l72.wav")
	$MarginContainer/VBoxContainer/VBoxContainer/Play.grab_focus()
	# Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/Play.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Play.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Option.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Option.grab_focus()
		
#func _on_Play_pressed():
#	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn")

func _on_Play_pressed():
	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn") # Replace with function body.


func _on_Option_pressed():
	get_tree().change_scene("res://options.tscn") # Replace with function body.

func _process(delta):
	
	if variable.light_mode == 1 :
		$MarginContainer/VBoxContainer/VBoxContainer/Play.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Option.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/TextureRect.set("texture", logo_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Play/Label.set("custom_colors/font_color", Color(0,0,0))
		$MarginContainer/VBoxContainer/VBoxContainer/Option/Label.set("custom_colors/font_color", Color(0,0,0))
		
	if variable.light_mode == 0 :
		$MarginContainer/VBoxContainer/VBoxContainer/Play.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/VBoxContainer/Option.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/TextureRect.set("texture", logo)
		$MarginContainer/VBoxContainer/VBoxContainer/Play/Label.set("custom_colors/font_color", Color(1,1,1))
		$MarginContainer/VBoxContainer/VBoxContainer/Option/Label.set("custom_colors/font_color", Color(1,1,1))
	
	if(variable.language==1):
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Play/Label").set_text('เล่น')
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Option/Label").set_text('ตั้งค่า')
	else:
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Play/Label").set_text('PLAY')
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Option/Label").set_text('OPTIONS')