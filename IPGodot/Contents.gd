extends Node
class_name Contents

# Search
var IPcontent = ["What is a IP.",
"IP Types.",
"Why IP is important.",
"How identify a IP.",
"How protect a IP",
"How comercialize a IP.",
"IP violation."]

var DEVcontent = ["Book", "Art", "App", "Music", "Mark", "Patent"]

# Feelings:
var introduce = "Let's develop something. I need gain some momey or I will break at the end of the month..."

var missing = ["Hummmm... I need search for something to develop first!",
"Oh no! I'm at end of the month... And I have no money!!!"]

var doubts = [""]
	


func _on_Button_button_down():
	var position = 0
	for dev in DEVcontent:
		if $Button.text == dev:
			DEVcontent.erase(dev)
		position += 1
	
	position = 0
	for ip in IPcontent:
		if $Button.text == ip:
			IPcontent.erase(ip)
		position += 1
