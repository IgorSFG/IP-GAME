extends Node

const ListContents = preload("res://Contents.tscn")
const listcontents = preload("res://Contents.gd")

#Search/Dev
const DEVcontent = listcontents.DEVcontent
const IPcontent = listcontents.IPcontent
const LRNcontent = listcontents.LRNcontent

#Feelings
const intro = listcontents.introduce
const miss = listcontents.missing
const feels = listcontents.feels

const daytime = 0.1

var namee = ""
var contents = []

var timer = Timer.new()
var day = 1
var month = 0

signal daypassed(day)
signal contentDeveloped(content)

func _ready():
	_invisible()
	timer.connect("timeout",self,"timeLefting")
	timer.wait_time = daytime
	timer.one_shot = false
	add_child(timer)
	timer.start()
	
func timeLefting():
	day += 1
	emit_signal("daypassed", day)
	if day == 27:
		showDialogue(miss[1])
	if day >= 30:
		day = 0
		month += 1
		if month >= 6:
			Events()
			month = 0
		
func showDialogue(dialogue):
	$Dialogue.visible = true
	$Dialogue/ColorRect/Text.text = str(namee) + ": " + str(dialogue)
	
func Events():
	for ip in IPcontent:
		if contents.has(ip):
			var pos = IPcontent.find(ip)
			showDialogue(feels[pos])

func add_content(value, context):
	var content = ListContents.instance()
	var contentButton = content.get_node("ContentButton")
	var contentText = content.get_node("ContentButton/Text")
	contentText.text = str(value)
	
	if context == "search": contentButton.connect("pressed", self, "contentSearched", [contentText.text])
	elif context == "develop": contentButton.connect("pressed", self, "contentDeveloped", [contentText.text])
	
	content.rect_min_size = Vector2(75,5)
	$Panel/Scroll/List.add_child(content)
	
func contentSearched(content):
	print("Searching...")
	if contents.has(content): return
	contents.append(content)
	_invisible()
	contentLearned(content)

func contentDeveloped(content):
	emit_signal("contentDeveloped", content)
	

func contentLearned(content):
		if IPcontent.has(content):
			var pos = IPcontent.find(content)
			add_content(LRNcontent[pos], "0")
			$Panel.visible = true


func _on_Player_search_pressed(level):
	var count = 0
	for dev in DEVcontent:
		if level >= count:
			if !contents.has(dev):
				add_content(dev, "search")
		count += 5

	count = 10
	for ip in IPcontent:
		if level >= count:
			if !contents.has(ip):
				add_content(ip, "search")
		count += 10
		
	$Panel.visible = true

func _on_Player_develop_pressed(level):
	print("Develop Pressed")
	if contents.empty(): 
		showDialogue(miss[0])
		return
		
	for dev in contents:
		if !IPcontent.has(dev):
			add_content(dev, "develop")

	$Panel.visible = true


func _invisible():
	$Panel.visible = false
	$Dialogue.visible = false
	$Player/Actions. visible = false
	for child in $Panel/Scroll/List.get_child_count():
		$Panel/Scroll/List.get_child(child).queue_free()


func _on_ExitButton_button_down():
	_invisible()


func _on_Player__invisible():
	_invisible()
