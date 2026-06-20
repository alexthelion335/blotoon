extends Camera3D

@export var camera_distance: float = 5.0
@export var camera_height: float = 2.0
@export var camera_smoothing: float = 8.0
@export var max_pitch: float = 1.0
@export var min_pitch: float = -0.5

var pitch: float = 0.0
var target_position: Vector3 = Vector3.ZERO

func _ready() -> void:
	position = Vector3(0, camera_height, camera_distance)

func rotate_camera(delta_pitch: float) -> void:
	pitch = clamp(pitch + delta_pitch, min_pitch, max_pitch)

func _process(delta: float) -> void:
	var parent = get_parent()
	if parent:
		var player_pos = parent.global_position
		var player_angle = parent.rotation.y

		var horizontal_distance = camera_distance * cos(pitch)
		var vertical_offset = camera_distance * sin(pitch)

		target_position = player_pos + Vector3(
		-sin(player_angle) * horizontal_distance,
		camera_height + vertical_offset,
		cos(player_angle) * horizontal_distance
		)

		position = position.lerp(target_position, camera_smoothing * delta)
		look_at(player_pos + Vector3(0, 1.0, 0), Vector3.UP)
