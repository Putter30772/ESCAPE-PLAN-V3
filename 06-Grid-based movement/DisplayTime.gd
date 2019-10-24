extends Label

onready var timer = get_node("Timer")
var start = 0

func _ready():
	pass

func _process(delta):
	if(variable.ready==1):
		if(variable.pause==1):
			timer.set_paused(true)
		else:
			timer.set_paused(false)
		if(start==0 || variable.move==1):
			variable.startTime = 10
			timer.set_wait_time(1)
			timer.start()
			start = 1
			variable.move=0 
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

