extends KinematicBody2D

signal search_pressed
signal develop_pressed
signal feelings_pressed
signal historic_pressed
signal _invisible

var money = 1000
var generallevel = 0
var booklevel = 0
var artlevel = 0
var applevel = 0
var musiclevel = 0
var marklevel = 0
var patentlevel = 0

var feelings = "Beatiful day :D"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Actions.visible = false
	$HUD/GridContainer/GeneralLevel.text = "Level: " + str(generallevel)
	$HUD/GridContainer/Money.text = "$" + str(money)
	$HUD/GridContainer/Day.text = "Day: 1"
	$PlayerArt/AnimationPlayer.play("Idle")

func levelUP(level, xp):
	level += xp
	generallevel += xp
	$HUD/GridContainer/GeneralLevel.text = "Level: " + str(generallevel)
	gainMoney(5*level)
	return level

func gainMoney(gain):
	money = round(money + gain)
	$HUD/GridContainer/Money.text = "$" + str(money)

func payMoney(pay):
	money = round(money - pay)
	$HUD/GridContainer/Money.text = "$" + str(money)
	if money < 0: get_tree().change_scene("res://gameover.tscn")
	
func _on_Main_daypassed(day):
	$HUD/GridContainer/Day.text = "Day: " + str(day)
	if day >= 30:
		payMoney(500)

func _on_GoActions_toggled(_button_pressed):
	$Actions.visible = true

func _on_Search_button_down():
	emit_signal("search_pressed", generallevel)
	
func _on_Main_contentLearned(content):
	feelings = content


func _on_Develop_button_down():
	emit_signal("develop_pressed", generallevel)
	
func _on_Main_contentDeveloped(content):
	if content == "Book": booklevel = levelUP(booklevel, 1)
	elif content == "Art": artlevel = levelUP(artlevel, 1)
	elif content == "App": applevel = levelUP(applevel, 1)
	elif content == "Music": musiclevel = levelUP(musiclevel, 1)
	elif content == "Mark": marklevel = levelUP(marklevel, 1)
	elif content == "Patent": patentlevel = levelUP(patentlevel, 1)
	emit_signal("_invisible")


func _on_Feelings_button_down():
	emit_signal("feelings_pressed", feelings)


func _on_Historic_button_down():
	emit_signal("historic_pressed")


func _on_Main_eventOcurred(event):
	if booklevel >= 2: booklevel -= (1 - event)
	if artlevel >= 2: artlevel -= (1 - event)
	if applevel >= 2: applevel -= (1 - event)
	if musiclevel >= 2: musiclevel -= (1 - event)
	if marklevel >= 2: marklevel -= (1 - event)
	if patentlevel >= 2: patentlevel -= (1 - event)
	generallevel = booklevel + artlevel + applevel + musiclevel + marklevel + patentlevel
	$HUD/GridContainer/GeneralLevel.text = "Level: " + str(generallevel)

