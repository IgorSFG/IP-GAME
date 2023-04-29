extends KinematicBody2D

signal search_pressed
signal develop_pressed

var namee = ""
var money = 1000
var generalLevel = 1
var bookLevel = 0
var artLevel = 0
var appLevel = 0
var musicLevel = 0
var markLevel = 0
var patentLevel = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Actions.visible = false
	$HUD/GridContainer/Money.text = "$" + str(money)
	$HUD/GridContainer/Day.text = "Day: 1"
	$PlayerArt/AnimationPlayer.play("Idle")
	

#func _process(delta):
#	pass

func payMoney(pay):
	money = round(money - pay)
	$HUD/GridContainer/Money.text = "$" + str(money)
	

func _on_Main_daypassed(day):
	$HUD/GridContainer/Day.text = "Day: " + str(day)
	if day >= 30:
		payMoney(500)

func _on_GoActions_toggled(button_pressed):
	if $Actions.visible == false: $Actions.visible = true
	else: $Actions.visible = false

func _on_Search_button_down():
	emit_signal("search_pressed")


func _on_Develop_button_down():
	emit_signal("develop_pressed")
