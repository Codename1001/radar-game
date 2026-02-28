extends Node2D



var marker_colors = {"green":Color(0.369, 0.894, 0.106, 1.0),"red":Color(0.74, 0.074, 0.0),"blue":Color(0.0, 0.459, 0.735)}

var target_hit = false

@onready var sound1 =$"good blip"
@onready var sound2 = $"bad blip"

func change_color(color:String):
	modulate= marker_colors[color]




func move_marker(distance,target, type,Rotation):#,color):
	if target_hit == false:
		change_color("green")
		global_scale = Vector2(1,3)
		rotation = Rotation
		var duration = distance / 600
		var tween = create_tween()
		tween.tween_property(self,"position",target,duration).set_trans(Tween.TRANS_LINEAR)
		#new_marker.global_position = ray.get_collider().to_local(marker.position)        funny visual
		await get_tree().create_timer(duration).timeout
		target_hit = true
		if type.is_in_group("object"):
			sound2.play()
		else:
			sound1.play()
		tween = create_tween()
		tween.tween_property(self,"global_scale",Vector2(3,1),.05).set_trans(Tween.TRANS_LINEAR)
		await get_tree().create_timer(.05).timeout
		tween = create_tween()
		tween.tween_property(self,"global_scale",Vector2(5,5),.4).set_trans(Tween.TRANS_LINEAR)
		await get_tree().create_timer(.5).timeout
		tween = create_tween()
		tween.tween_property(self,"global_scale",Vector2(1,1),.4).set_trans(Tween.TRANS_LINEAR)
		if type.is_in_group("entity"):
			change_color("blue")
		if type.is_in_group("enemy"):
			change_color("red")
		if type.is_in_group("object"):
			pass
