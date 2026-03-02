extends Node2D

@export var faded = false

var scan = false
var radar_ping = true


func change_color(color:String):
	modulate= globalVars.marker_colors[color]


func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(0.0, 0.0, 0.0, 0.0),2)

func _physics_process(delta: float) -> void:
	if modulate == Color(0.0, 0.0, 0.0, 0.0):
		queue_free()
