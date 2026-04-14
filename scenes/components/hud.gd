extends CanvasLayer


@export var health :Control
@export var position :Control
@export var ammo :Control
@export var ammo_type :Control
@export var speed :Control
@export var data_display :Control
@export var bulet_type_button :Control
@export var command_line : Control


@onready var selected_bulet_type

var menu_show = false




func _ready() -> void:
	selected_bulet_type = bulet_type_button.get_item_text(bulet_type_button.get_selected_id())
	update_hud_data()
	bulet_type_button.grab_focus()

func update_menu_data():
	selected_bulet_type = bulet_type_button.get_item_text(bulet_type_button.get_selected_id())



func _process(delta: float) -> void:
	update_menu_data()
	if Input.is_action_just_pressed("ui_cancel") and menu_show == false:
		#$Control/MarginContainer/menu.show()
		#$Control/MarginContainer/PanelContainer.hide()
		globalVars.control = false
		menu_show = true
		#$"Control/MarginContainer/menu/TabContainer/ship loadout".grab_focus()
	elif Input.is_action_just_pressed("ui_cancel") and menu_show == true:
		#$Control/MarginContainer/menu.hide()
		#$Control/MarginContainer/PanelContainer.show()
		globalVars.control = true
		menu_show = false
		bulet_type_button.grab_focus()

func update_hud_data():
	health.text = "health: " +str(globalVars.data.health)
	position.text = "position" + "\n("  +str(roundi(globalVars.data.position.x)) + ", " + str(roundi(globalVars.data.position.y))+ ")"
	ammo.text = "ammo: " + str(globalVars.data.ammo_type[selected_bulet_type]) + " Rnd's"
	ammo_type.text = "ammo_type: " + str(selected_bulet_type)
	speed.text = "speed : " + str(globalVars.data.speed) + "m/s"
	data_display.text =""

	pass
