extends Node2D



var marker_colors = {"green":Color(0.369, 0.894, 0.106, 1.0),"red":Color(0.74, 0.074, 0.0),"blue":Color(0.0, 0.459, 0.735)}


func change_color(color:String):
	modulate= marker_colors[color]


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
