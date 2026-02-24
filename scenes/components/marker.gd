extends Node2D

@export var faded = false

var scan = false
var radar_ping = true
var marker_colors = {"green":Color(0.369, 0.894, 0.106, 1.0),"red":Color(0.74, 0.074, 0.0),"blue":Color(0.0, 0.459, 0.735)}

func change_color(color:String):
	modulate= marker_colors[color]


func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(0.0, 0.0, 0.0, 0.0),2)

func _physics_process(delta: float) -> void:
	if modulate == Color(0.0, 0.0, 0.0, 0.0):
		queue_free()
