extends CanvasLayer

@onready var data_display = $Control/data_desplay
@onready var bulet_type_button=$"Control/bulet type"
var menu_show = false

@onready var selected_bulet_type


func _ready() -> void:
	selected_bulet_type = bulet_type_button.get_item_text(bulet_type_button.get_selected_id())
	update_hud_data()
	bulet_type_button.grab_focus()

func update_menu_data():
	selected_bulet_type = bulet_type_button.get_item_text(bulet_type_button.get_selected_id())



func _process(delta: float) -> void:
	update_menu_data()
	if Input.is_action_just_pressed("ui_cancel") and menu_show == false:
		$Control/MarginContainer/menu.show()
		$Control/MarginContainer/PanelContainer.hide()
		globalVars.control = false
		menu_show = true
		$"Control/MarginContainer/menu/TabContainer/ship loadout".grab_focus()
	elif Input.is_action_just_pressed("ui_cancel") and menu_show == true:
		$Control/MarginContainer/menu.hide()
		$Control/MarginContainer/PanelContainer.show()
		globalVars.control = true
		menu_show = false
		bulet_type_button.grab_focus()

func update_hud_data():
	data_display.text = "speed : " + str(globalVars.data.speed) + "m/s"  +"\nhealth: " +str(globalVars.data.health)+"								ammo: " + str(globalVars.data.ammo_type[selected_bulet_type]) + " Rnd's" + "\nposition: \n(" +str(roundi(globalVars.data.position.x)) + ", " + str(roundi(globalVars.data.position.y))+ ")" + "	ammo_type: "+ "\n\n\n"

	pass
