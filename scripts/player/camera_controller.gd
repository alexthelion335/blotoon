extends Camera3D

@export var camera_distance = 5.0
@export var camera_height = 2.0
@export var camera_smoothing = 10.0
@export var max_pitch = PI / 3  # 60 degrees up
@export var min_pitch = -PI / 4  # 45 degrees down

var pitch = 0.0
var target_position = Vector3.ZERO

func _ready():
	position = Vector3(0, camera_height, camera_distance)

func rotate_camera(delta_pitch: float):
	pitch = clamp(pitch + delta_pitch, -max_pitch, min_pitch)

func _process(delta):
	var parent = get_parent()
	if parent:
		# Calculate target camera position relative to parent
		target_position = Vector3(
			-sin(parent.rotation.y) * camera_distance,
			camera_height + sin(pitch) * camera_distance,
			cos(parent.rotation.y) * camera_distance
		)
		
		# Smooth camera movement
		position = position.lerp(target_position, camera_smoothing * delta)
		
		# Look at player
		look_at(parent.global_position + Vector3(0, 1, 0), Vector3.UP)
