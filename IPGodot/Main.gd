extends Contents

const ListContents = preload("res://Contents.tscn")

var timer = Timer.new()
var day = 1

signal daypassed(day)

func _ready():
	$Panel.visible = false
	timing()

	
	
func timing():
	timer.connect("timeout",self,"timeLefting")
	timer.wait_time = 0.1
	add_child(timer)
	timer.start()
	
func timeLefting():
	day += 1
	emit_signal("daypassed", day)
	if day >= 30:
		day = 0
		
func add_content(value):
	var content = ListContents.instance()
	content.get_node("Button").text = value
	content.rect_min_size = Vector2(75,5)
	$Panel/Scroll/List.add_child(content)


func _on_Player_search_pressed():
	$Panel.visible = true
	
	var count = 0
	for dev in DEVcontent:
		add_content(dev)
		count += 1

	count = 0
	for ip in IPcontent:
		add_content(ip)
		count += 1


func _on_ExitButton_button_down():
	$Panel.visible = false
	$Player/Actions.visible = false
	for child in $Panel/Scroll/List.get_child_count():
		$Panel/Scroll/List.get_child(child).queue_free()
