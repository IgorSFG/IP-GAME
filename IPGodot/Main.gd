extends Node

const ListContents = preload("res://Contents.tscn")
const listcontents = preload("res://Contents.gd")

#Search/Dev
const DEVcontent = listcontents.DEVcontent
const IPcontent = listcontents.IPcontent

#Feelings
const intro = listcontents.introduce
const miss = listcontents.missing
const doubt = listcontents.doubts

const daytime = 0.1

var devcontent = []
var ipcontent = []

var timer = Timer.new()
var day = 1

signal daypassed(day)

func _ready():
	$Panel.visible = false
	$Dialogue.visible = false
	timing("timeLefting", daytime, false)

func timing(_func, time, shot):
	timer.connect("timeout",self,_func)
	timer.wait_time = time
	timer.one_shot = shot
	add_child(timer)
	timer.start()
	
func timeLefting():
	day += 1
	emit_signal("daypassed", day)
	if day >= 30:
		day = 0
		
func showDialogue(dialogue, namee):
	$Dialogue.visible = true
	$Dialogue/ColorRect/Text.text = str(namee) + ": " + str(dialogue)

func add_content(value, context):
	var content = ListContents.instance()
	var contentButton = content.get_node("ContentButton")
	contentButton.text = value
	
	if context == "search": contentButton.connect("pressed", self, "contentSearch", [contentButton.text])
	elif context == "develop": contentButton.connect("pressed", self, "contentDevelop", [contentButton.text])
	
	content.rect_min_size = Vector2(75,5)
	$Panel/Scroll/List.add_child(content)
	
func contentSearch(content):
	print("Searching...")
	if devcontent.has(content): return
	devcontent.append(content)
	DEVcontent.erase(content)
	IPcontent.erase(content)

func contentDevelop(content):
	pass

func _on_Player_search_pressed(level):
	$Panel.visible = true
	
	var count = 0
	for dev in DEVcontent:
		add_content(dev, "search")
		count += 1

	count = 0
	for ip in IPcontent:
		add_content(ip, "search")
		count += 1

func _on_Player_develop_pressed(level, namee):
	print("Develop Pressed")
	if devcontent.empty():
		showDialogue(miss[0], namee)
		return
		
	var count = 0
	for dev in devcontent:
		add_content(dev, "develop")
		count += 1
	
	
	
	$Panel.visible = true



func _on_ExitButton_button_down():
	$Panel.visible = false
	$Dialogue.visible = false
	$Player/Actions.visible = false
	for child in $Panel/Scroll/List.get_child_count():
		$Panel/Scroll/List.get_child(child).queue_free()
