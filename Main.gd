extends Control

const MENU = preload("res://Menu.tscn")
@onready var flow_container = $FlowContainer

func _ready():
	_refresh()

func _refresh():
	var interfaces = IP.get_local_interfaces()
	for node in flow_container.get_children():
		if node.name != "Refresh": node.queue_free()
	await get_tree().create_timer(0.5).timeout
	for interface in interfaces:
		var menu = MENU.instantiate()
		flow_container.add_child(menu)
		menu.get_node("Scont/Vbox/Label").text = interface["friendly"] + " | " + interface["name"]
		menu.get_node("Scont/Vbox/Label2").text = "|---------------------|\n" + str(interface["addresses"])


