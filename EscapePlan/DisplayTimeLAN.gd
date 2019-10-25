extends Label

onready var timer = get_node("TimerLAN")
var start = 0

func _ready():
	pass

func _process(delta):
	if(variableLAN.ready==1):
		if(start==0 || variableLAN.move==1):
			variableLAN.startTime = 10
			timer.set_wait_time(1)
			timer.start()
			start = 1
			variableLAN.move=0 
		if(variableLAN.startTime==10):
			set_text("00:" + str(variableLAN.startTime))
		if(variableLAN.startTime<10 && variableLAN.startTime>=0):
			set_text("00:0" + str(variableLAN.startTime))
		if(variableLAN.startTime<0):
			if(variableLAN.turn==1):
				variableLAN.turn=0
			else:
				variableLAN.turn=1
			variableLAN.startTime=10
	else:
		set_text("00:" + str(10))
		


func _on_TimerLAN_timeout():
	variableLAN.startTime -= 1 
