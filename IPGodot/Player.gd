extends KinematicBody2D

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
	$HUD/GridContainer/Money.text = "$" + str(money) + ",00"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func payMoney(pay):
	money = round(money - pay)
	$HUD/GridContainer/Money.text = "$" + str(money) + ",00"
	


func _on_Main_daypassed(day):
	payMoney(500)
