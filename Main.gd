extends Control

const MENU = preload("res://Menu.tscn")
@onready var flow_container = $MCont/Vbox/SCont/FlowContainer
@onready var label = $MCont/Vbox/Ip_List/Label


func _ready():
	_refresh()
	print(str(OS.get_environment("HOSTNAME")))

func _refresh():
	var interfaces = IP.get_local_interfaces()
	for node in flow_container.get_children():
		if node.name != "Refresh": node.queue_free()
	label.text = ""
	await get_tree().create_timer(0.25).timeout
	for i in interfaces.size():
		var menu = MENU.instantiate()
		flow_container.add_child(menu)
		menu.get_node("Scont/Vbox/Hbox/Label").text = str(i) + " =>"
		menu.get_node("Scont/Vbox/Hbox/Label2").text = interfaces[i]['friendly'] + "\n" + interfaces[i]["name"]
		menu.get_node("Scont/Vbox/Label2").text = str(interfaces[i]["addresses"])
	label.text = str(IP.get_local_addresses())


