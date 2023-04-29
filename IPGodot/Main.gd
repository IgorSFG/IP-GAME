extends Node

var timer = Timer.new()
var day = 1

signal daypassed(day)

func _ready():
	timing()

	
	
func timing():
	timer.connect("timeout",self,"timeLefting")
	timer.wait_time = 60
	add_child(timer)
	timer.start()
	
func timeLefting():
	day += 1
	emit_signal("daypassed", day)

