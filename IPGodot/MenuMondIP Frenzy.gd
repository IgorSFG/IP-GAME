extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.playing = true

func _on_JogarButton_pressed(): 
	get_tree().change_scene("res://Main.tscn")
	
func _on_SairButton_pressed():
	$AudioStreamPlayer.stop()
	get_tree().quit()
	
