extends Node

onready var timer = $PlayerSearchTimeout
var cursor100 = preload("res://TitleScreenRelated/cursor100.png")
var cursor100_light = preload("res://TitleScreenRelated/cursor100_light.png")
var gamemodes = preload("res://TitleScreenRelated/prison_gamemodes.png")
var gamemodes_light = preload("res://TitleScreenRelated/prison_gamemodes_light.png")

func _process(delta):
	if variable.light_mode == 0 :
		$MarginContainer/Gamemode/Menu/Back_Button.set("texture_hover", cursor100)
		$MarginContainer/Gamemode/Menu/vsCom_Button.set("texture_hover", cursor100)
		$MarginContainer/Gamemode/Menu/vsLocal_Button.set("texture_hover", cursor100)
		$MarginContainer/Gamemode/Menu/vsOnline_Button.set("texture_hover", cursor100)
		$MarginContainer/Gamemode/Gamemode_Logo.set("texture", gamemodes)
		$MarginContainer/Gamemode/Menu/Back_Button/Label.set("custom_colors/font_color", Color(1,1,1))
		$MarginContainer/Gamemode/Menu/vsCom_Button/vsCom.set("custom_colors/font_color", Color(1,1,1))
		$MarginContainer/Gamemode/Menu/vsLocal_Button/vsLocal.set("custom_colors/font_color", Color(1,1,1))
		$MarginContainer/Gamemode/Menu/vsOnline_Button/vsOnline.set("custom_colors/font_color", Color(1,1,1))
		
	if variable.light_mode == 1 :
		$MarginContainer/Gamemode/Menu/Back_Button.set("texture_hover", cursor100_light)
		$MarginContainer/Gamemode/Menu/vsCom_Button.set("texture_hover", cursor100_light)
		$MarginContainer/Gamemode/Menu/vsLocal_Button.set("texture_hover", cursor100_light)
		$MarginContainer/Gamemode/Menu/vsOnline_Button.set("texture_hover", cursor100_light)
		$MarginContainer/Gamemode/Gamemode_Logo.set("texture", gamemodes_light)
		$MarginContainer/Gamemode/Menu/Back_Button/Label.set("custom_colors/font_color", Color(0,0,0))
		$MarginContainer/Gamemode/Menu/vsCom_Button/vsCom.set("custom_colors/font_color", Color(0,0,0))
		$MarginContainer/Gamemode/Menu/vsLocal_Button/vsLocal.set("custom_colors/font_color", Color(0,0,0))
		$MarginContainer/Gamemode/Menu/vsOnline_Button/vsOnline.set("custom_colors/font_color", Color(0,0,0))

func _ready():
	Lobby.room = self
	$MarginContainer/Gamemode/Menu/vsOnline_Button.grab_focus()
	pass
	
func _on_connection_failed(error):
	$labelStatus.text = "Error connecting to the server " + error

func _success():
	print("success")
	timer.start()
	Lobby.look_for_player()

func stop_looking():
	print("stop looking")
	timer.stop()
	get_tree().change_scene("res://Game.tscn")
	Lobby.get_layout(variable.grid)
	Lobby.send_name(variable.playerName,Lobby.session_id)

func _on_PlayerSearchTimeout_timeout():
	Lobby.look_for_player()


#func _on_Back_pressed():
#	get_tree().change_scene("res://TitleScreenRelated/TitleScreen.tscn")

#func _on_PVP_ShareScreen_pressed():
#	variableLAN.mode = 1
#	get_tree().change_scene("res://LAN.tscn")

#func _on_PVE_pressed():
#	get_tree().change_scene("res://BotModeScreen.tscn")

func _on_Back_Button_pressed():
	get_tree().change_scene("res://TitleScreenRelated/TitleScreen.tscn") # Replace with function body.


func _on_vsCom_Button_pressed():
	get_tree().change_scene("res://BotModeScreen.tscn") # Replace with function body.


func _on_vsLocal_Button_pressed():
	MusicController.stop()
	variableLAN.mode = 1
	get_tree().change_scene("res://LAN.tscn") # Replace with function body.
	
func _physics_process(delta):
	if $MarginContainer/Gamemode/Menu/vsOnline_Button.is_hovered() :
		$MarginContainer/Gamemode/Menu/vsOnline_Button.grab_focus()
	if $MarginContainer/Gamemode/Menu/vsCom_Button.is_hovered() :
		$MarginContainer/Gamemode/Menu/vsCom_Button.grab_focus()
	if $MarginContainer/Gamemode/Menu/vsLocal_Button.is_hovered() :
		$MarginContainer/Gamemode/Menu/vsLocal_Button.grab_focus()
	if $MarginContainer/Gamemode/Menu/Back_Button.is_hovered() :
		$MarginContainer/Gamemode/Menu/Back_Button.grab_focus()
		
	if(variable.language==1):
		get_node("MarginContainer/Gamemode/Menu/vsOnline_Button/vsOnline").set_text("เล่นออนไลน์")
		get_node("MarginContainer/Gamemode/Menu/vsLocal_Button/vsLocal").set_text("เล่นกันเอง")
		get_node("MarginContainer/Gamemode/Menu/vsCom_Button/vsCom").set_text("เล่นกับคอม")
		get_node("MarginContainer/Gamemode/Menu/Back_Button/Label").set_text("กลับ")
		get_node("Insert Name Dialog/Play").set_text("เล่น")
		get_node("Insert Name Dialog/Label").set_text("ใส่ชื่อ")
	else:
		get_node("MarginContainer/Gamemode/Menu/vsOnline_Button/vsOnline").set_text("VS ONLINE")
		get_node("MarginContainer/Gamemode/Menu/vsLocal_Button/vsLocal").set_text("VS LOCAL")
		get_node("MarginContainer/Gamemode/Menu/vsCom_Button/vsCom").set_text("VS COM")
		get_node("MarginContainer/Gamemode/Menu/Back_Button/Label").set_text("BACK")
		get_node("Insert Name Dialog/Play").set_text("PLAY")
		get_node("Insert Name Dialog/Label").set_text("Insert Your Name")


func _on_Play_pressed():
	MusicController.stop()
	print("on Play pressed")
	variable.score = 0
	variable.opponent_score = 0
	variable.playerName = get_node("Insert Name Dialog/LineEdit").get_text()
	var network = NetworkedMultiplayerENet.new()
	network.create_client("127.0.0.1", 6969)
	get_tree().set_network_peer(network)
	network.connect("connection_failed",self,"_on_connection_failed")
	network.connect("connection_succeeded",self,"_success") # Replace with function body.
