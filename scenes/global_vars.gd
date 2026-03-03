extends Node2D


var marker_colors = {"green":Color(0.369, 0.894, 0.106, 1.0),"red":Color(0.74, 0.074, 0.0),"blue":Color(0.0, 0.459, 0.735),"purple":Color(0.713, 0.003, 0.978, 1.0)}
var data = { "speed" : 0, "health": 100,"ammo_type":{"tracking_beacon": 200, "standerd_torpedo":1000} , "position": Vector2.ZERO}
#var data = { "speed" : 0, "health": 100, "ammo":20,"ammo_type":"traking_becon" , "position": Vector2.ZERO}
var control = true
