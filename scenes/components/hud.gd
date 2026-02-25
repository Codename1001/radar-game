extends CanvasLayer

@onready var data_display = $Control/Node2D/VSplitContainer/RichTextLabel
var data = { "speed" : 0, "health": 100, "ammo":0,"ammo_type":"traking_becon" , "position": Vector2.ZERO}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_hud_data():
	data_display.text = "speed : " + str(data.speed) + "m/s" + "\nhealth: " +str(data.health)+  "\nposition: \n(" +str(roundi(data.position.x)) + ", " + str(roundi(data.position.y))+ ")" + "\n\n\n"
	data_display.text +=  "\nammo: " + str(data.ammo) + " Rnd's" +"\nammo_type: " + data.ammo_type
