extends Node3D

@onready var _slot_machine := $Slot/SlotMachine3D as Node3D
@onready var _spin_button := $Slot/Buttons/SpinButton as Node3D
@onready var _spin_lever := $Slot/Buttons/SpinLever as Node3D
@onready var _cam := $Cam as Camera3D
@onready var _anim := $AnimPlayer as AnimationPlayer


func _ready() -> void:
	_anim.play("CameraAnim/intro")
	await get_tree().create_timer(5.0).timeout
	start_spin()


func start_spin() -> void:
	if _slot_machine.state > 0:
		return
	
	_slot_machine.spin()
	await get_tree().create_timer(1.5).timeout
	stop_spin()


func stop_spin() -> void:
	_slot_machine.stop()


## Signals
func _on_spin_button_input(camera, event, position, normal, shape_idx):
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		var t = get_tree().create_tween()
		t.tween_property(_spin_button, "position:x", 0.0, 0.2)
		await t.finished
		
		start_spin()
		t = get_tree().create_tween()
		t.tween_property(_spin_button, "position:x", 0.15, 0.1)


func _on_spin_lever_input(camera, event, position, normal, shape_idx):
	var mouse_click = event as InputEventMouseButton
	if mouse_click and mouse_click.button_index == 1 and mouse_click.pressed:
		var t = get_tree().create_tween()
		t.tween_property(_spin_lever, "rotation:z", -0.5, 0.3)
		await t.finished
		
		start_spin()
		t = get_tree().create_tween()
		t.tween_property(_spin_lever, "rotation:z", 0.0, 0.3)
##
