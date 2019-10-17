extends Label

onready var timer = get_node("Timer")

func _ready():
	if(variable.gameStart==1):
		timer.set_wait_time(1)
		timer.start() 

func _process(delta):
	if(variable.gameStart==1):
		if(variable.startTime==10):
			set_text("00:" + str(variable.startTime))
		if(variable.startTime<10 && variable.startTime>=0):
			set_text("00:0" + str(variable.startTime))
		if(variable.startTime<0):
			if(variable.turn==1):
				variable.turn=0
			else:
				variable.turn=1
			variable.startTime=10
	else:
		set_text("00:" + str(10))
func _on_Timer_timeout():
	variable.startTime -= 1 

