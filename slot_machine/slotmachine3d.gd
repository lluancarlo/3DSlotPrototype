extends Node3D
class_name SlotMachine3D

enum enum_state {STOPPED, SPINNING}
#
@onready var _reels := $Reels as Node3D
#
var state := enum_state.STOPPED
var reels : Array[Reels3D] = []


func _ready() -> void:
	reels.append_array(_reels.get_children())


func spin() -> void:
	if state != enum_state.STOPPED:
		return
	
	state = enum_state.SPINNING
	
	for r in reels:
		r.spin()


func stop() -> void:
	randomize()
	
	# Set symbols to stop
	for r in reels:
		r.stop_symbol = randi_range(1, 16)
	
	# Stop reels
	var sequence: PackedInt32Array
	for r in reels:
		r.can_stop = true
		await r.stopped
		await get_tree().create_timer(0.1).timeout
		sequence.append(r.curr_symbol)
	
	print(sequence)
	
	state = enum_state.STOPPED
