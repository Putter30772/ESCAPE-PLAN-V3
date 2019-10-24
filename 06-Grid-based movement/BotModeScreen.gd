extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cursor100_light = preload("res://TitleScreenRelated/cursor100_light.png")
var cursor100 = preload("res://TitleScreenRelated/cursor100.png")
var diffy = preload("res://TitleScreenRelated/prison_difficulty.png")
var diffy_light = preload("res://TitleScreenRelated/prison_difficulty_light.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/Easy_Button.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/Back_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Back_Button.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Hard_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Hard_Button.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Normal_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Normal_Button.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Easy_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Easy_Button.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/Madness_Button.is_hovered() :
		$MarginContainer/VBoxContainer/VBoxContainer/Madness_Button.grab_focus()
		
func _on_Hard_Button_pressed():
	variableLAN.mode = 2
	variableLAN.botdifficulty = 3
	get_tree().change_scene("res://LAN.tscn")


func _on_Normal_Button_pressed():
	variableLAN.mode = 2
	variableLAN.botdifficulty = 2
	get_tree().change_scene("res://LAN.tscn")


func _on_Easy_Button_pressed():
	variableLAN.mode = 2
	variableLAN.botdifficulty = 1
	get_tree().change_scene("res://LAN.tscn")


func _on_Back_Button_pressed():
	get_tree().change_scene("res://TitleScreenRelated/GameModeScreen.tscn")

func _process(delta):
	if(variable.language==1):
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Hard_Button/Label").set_text("ยาก")
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Normal_Button/Label").set_text("ปานกลาง")
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Easy_Button/Label").set_text("ง่าย")
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Back_Button/Label").set_text("กลับ")
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Madness_Button/Label").set_text("สุ่ม")
	else:
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Hard_Button/Label").set_text("HARD")
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Normal_Button/Label").set_text("NORMAL")
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Easy_Button/Label").set_text("EASY")
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Back_Button/Label").set_text("BACK")
		get_node("MarginContainer/VBoxContainer/VBoxContainer/Madness_Button/Label").set_text("RANDOM")
		
		
	if variable.light_mode == 1 :
		$MarginContainer/VBoxContainer/TextureRect.set("texture", diffy_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Hard_Button.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Normal_Button.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Madness_Button.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Easy_Button.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/VBoxContainer/Back_Button.set("texture_hover", cursor100_light)
		
		$MarginContainer/VBoxContainer/VBoxContainer/Hard_Button/Label.set("custom_colors/font_color", Color(0,0,0))
		$MarginContainer/VBoxContainer/VBoxContainer/Normal_Button/Label.set("custom_colors/font_color", Color(0,0,0))
		$MarginContainer/VBoxContainer/VBoxContainer/Madness_Button/Label.set("custom_colors/font_color", Color(0,0,0))
		$MarginContainer/VBoxContainer/VBoxContainer/Easy_Button/Label.set("custom_colors/font_color", Color(0,0,0))
		$MarginContainer/VBoxContainer/VBoxContainer/Back_Button/Label.set("custom_colors/font_color", Color(0,0,0))
		
	else : 
		$MarginContainer/VBoxContainer/TextureRect.set("texture", diffy)
		$MarginContainer/VBoxContainer/VBoxContainer/Hard_Button.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/VBoxContainer/Normal_Button.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/VBoxContainer/Madness_Button.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/VBoxContainer/Easy_Button.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/VBoxContainer/Back_Button.set("texture_hover", cursor100)
		
		$MarginContainer/VBoxContainer/VBoxContainer/Hard_Button/Label.set("custom_colors/font_color", Color(1,1,1))
		$MarginContainer/VBoxContainer/VBoxContainer/Normal_Button/Label.set("custom_colors/font_color", Color(1,1,1))
		$MarginContainer/VBoxContainer/VBoxContainer/Madness_Button/Label.set("custom_colors/font_color", Color(1,1,1))
		$MarginContainer/VBoxContainer/VBoxContainer/Easy_Button/Label.set("custom_colors/font_color", Color(1,1,1))
		$MarginContainer/VBoxContainer/VBoxContainer/Back_Button/Label.set("custom_colors/font_color", Color(1,1,1))
		

func _on_Madness_Button_pressed():
	variableLAN.mode = 3
	randomize()
	variableLAN.botdifficulty =  randi()% 3 + 1 
	randomize()
	variableLAN.gameSize = randi()% 5 + 3 
#	variableLAN.botno = 2
	get_tree().change_scene("res://LAN.tscn")
