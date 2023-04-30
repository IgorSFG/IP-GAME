extends Node

var unmuted_texture = load("res://sprites/soundIcon (1).png")
var muted_texture = load("res://sprites/soundIcon (2).png")

# Declare member variables here. Examples:
# var a = 2
var velocidade = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/JogarButton.grab_focus()

func _on_JogarButton_pressed():
		GameManager.health_score = 1000
		get_tree().change_scene("")
	
func _on_SairButton_pressed():
	get_tree().quit()
	pass # Replace with function body.


	$AudioStreamPlayer.stop()
	


func _on_TextureButton_pressed():
	GameManager.toggleMute()
	if !GameManager.is_muted:
		$TextureButton.texture_normal = unmuted_texture
	else: 
		$TextureButton.texture_normal = muted_texture
