extends Node3D

signal stopped()
#
const ROT_BASE = 22.5
#
@export var can_stop : bool
@export var stop_symbol : int
var spinning : bool
var can_spin : bool = true
var curr_symbol : int = 1


func spin() -> void:
	if not can_spin:
		return
	
	spinning = true
	var t = get_tree().create_tween()
	t.tween_property(self, "rotation:z", rotation.z + deg_to_rad(-ROT_BASE), 0.05)
	t.connect("finished", stop)


func stop() -> void:
	spinning = false
	curr_symbol = 1 if curr_symbol > 15 else curr_symbol + 1
	
	if can_stop and stop_symbol == curr_symbol:
		can_stop = false
		emit_signal("stopped")
	
	else:
		spin()
