extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skins = null
var skins2 = null
var cursor100_light = preload("res://TitleScreenRelated/cursor100_light.png")
var cursor100 = preload("res://TitleScreenRelated/cursor100.png")
var pskin1 = preload("res://Skins/P1S.png")
var pskin2 = preload("res://Skins/P2S.png")
var pskin2_hover = preload("res://Skins/P2H_light.png")
var pskin3 = preload("res://Skins/P3S.png")
var pskin4 = preload("res://Skins/P4S.png")
var wskin1 = preload("res://Skins/W1S.png")
var wskin2 = preload("res://Skins/W2S.png")
var wskin3 = preload("res://Skins/W3S.png")
var wskin4 = preload("res://Skins/W4S.png")
var pskin1_light = preload("res://Skins/P1S_light.png")
var pskin2_light = preload("res://Skins/P2S_light.png")
var pskin3_light = preload("res://Skins/P3S_light.png")
var pskin4_light = preload("res://Skins/P4S_light.png")
var wskin1_light = preload("res://Skins/W1S_light.png")
var wskin2_light = preload("res://Skins/W2S_light.png")
var wskin3_light = preload("res://Skins/W3S_light.png")
var wskin4_light = preload("res://Skins/W4S_light.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	skins = $MarginContainer/VBoxContainer/Prisoner.get_children()
	skins2 = $MarginContainer/VBoxContainer/Warden.get_children()
	skins[variable.skin_select].set("pressed", true)
	skins2[variable.skin2_select].set("pressed", true)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _process(delta):
	
	if variable.light_mode == 1 :
		$MarginContainer/VBoxContainer/back.set("texture_hover", cursor100_light)
		$MarginContainer/VBoxContainer/Text1.set("custom_colors/font_color", Color(0,0,0))
		$MarginContainer/VBoxContainer/Text2.set("custom_colors/font_color", Color(0,0,0))
		$MarginContainer/VBoxContainer/back/Label.set("custom_colors/font_color", Color(0,0,0))
		
		$MarginContainer/VBoxContainer/Prisoner/Skin1.set("texture_pressed", pskin1_light)
		$MarginContainer/VBoxContainer/Prisoner/Skin2.set("texture_pressed", pskin2_light)
		$MarginContainer/VBoxContainer/Prisoner/Skin2.set("texture_hover", pskin2_hover)
		$MarginContainer/VBoxContainer/Prisoner/Skin3.set("texture_pressed", pskin3_light)
		$MarginContainer/VBoxContainer/Prisoner/Skin4.set("texture_pressed", pskin4_light)
		
		$MarginContainer/VBoxContainer/Warden/W1.set("texture_pressed", wskin1_light)
		$MarginContainer/VBoxContainer/Warden/W2.set("texture_pressed", wskin2_light)
		$MarginContainer/VBoxContainer/Warden/W3.set("texture_pressed", wskin3_light)
		$MarginContainer/VBoxContainer/Warden/W4.set("texture_pressed", wskin4_light)
		
		
	else : 
		$MarginContainer/VBoxContainer/back.set("texture_hover", cursor100)
		$MarginContainer/VBoxContainer/Text1.set("custom_colors/font_color", Color(1,1,1))
		$MarginContainer/VBoxContainer/Text2.set("custom_colors/font_color", Color(1,1,1))
		$MarginContainer/VBoxContainer/back/Label.set("custom_colors/font_color", Color(1,1,1))
		
		$MarginContainer/VBoxContainer/Prisoner/Skin1.set("texture_pressed", pskin1)
		$MarginContainer/VBoxContainer/Prisoner/Skin2.set("texture_pressed", pskin2)
		$MarginContainer/VBoxContainer/Prisoner/Skin3.set("texture_pressed", pskin3)
		$MarginContainer/VBoxContainer/Prisoner/Skin4.set("texture_pressed", pskin4)
		
		$MarginContainer/VBoxContainer/Warden/W1.set("texture_pressed", wskin1)
		$MarginContainer/VBoxContainer/Warden/W2.set("texture_pressed", wskin2)
		$MarginContainer/VBoxContainer/Warden/W3.set("texture_pressed", wskin3)
		$MarginContainer/VBoxContainer/Warden/W4.set("texture_pressed", wskin4)
	
	if(variable.language==1):
		get_node('MarginContainer/VBoxContainer/Text1').set_text('นักโทษ')
		get_node('MarginContainer/VBoxContainer/Text2').set_text('ผู้คุม')
		get_node('MarginContainer/VBoxContainer/back/Label').set_text('กลับ')
	else: 
		get_node('MarginContainer/VBoxContainer/Text1').set_text('PRISONER')
		get_node('MarginContainer/VBoxContainer/Text2').set_text('WARDEN')
		get_node('MarginContainer/VBoxContainer/back/Label').set_text('BACK')

func _on_back_pressed():
	get_tree().change_scene("res://options.tscn")

 # Replace with function body.


func _on_Skin1_pressed():
	variable.skin_select = 0
	for i in range(4):
		if i != 0:
			skins[i].set("pressed", false)

func _on_Skin2_pressed():
	variable.skin_select = 1
	for i in range(4):
		if i != 1:
			skins[i].set("pressed", false)
	
func _on_Skin3_pressed():
	variable.skin_select = 2
	for i in range(4):
		if i != 2:
			skins[i].set("pressed", false)
			
func _on_Skin4_pressed():
	variable.skin_select = 3
	for i in range(4):
		if i != 3:
			skins[i].set("pressed", false)	 # Replace with function body.


func _on_W1_pressed():
	variable.skin2_select = 0
	for i in range(4):
		if i != 0:
			skins2[i].set("pressed", false) # Replace with function body.


func _on_W2_pressed():
	variable.skin2_select = 1
	for i in range(4):
		if i != 1:
			skins2[i].set("pressed", false) # Replace with function body.

func _on_W3_pressed():
	variable.skin2_select = 2
	for i in range(4):
		if i != 2:
			skins2[i].set("pressed", false) 

func _on_W4_pressed():
	variable.skin2_select = 3
	for i in range(4):
		if i != 3:
			skins2[i].set("pressed", false) 
