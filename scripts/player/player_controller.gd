extends CharacterBody3D

@export var move_speed: float = 7.0
@export var sprint_speed: float = 12.0
@export var acceleration: float = 25.0
@export var friction: float = 20.0
@export var jump_force: float = 8.0
@export var gravity: float = -9.8

var is_sprinting: bool = false
var camera_controller: Node3D

func _ready() -> void:
	camera_controller = $Camera3D
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	is_sprinting = Input.is_action_pressed("ui_select")

	var target_speed = sprint_speed if is_sprinting else move_speed
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = lerp(velocity.x, direction.x * target_speed, acceleration * delta)
		velocity.z = lerp(velocity.z, direction.z * target_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
		velocity.z = lerp(velocity.z, 0.0, friction * delta)

	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_force
		else:
			velocity.y += gravity * delta

		move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.005)
	if camera_controller:
		camera_controller.rotate_camera(event.relative.y * 0.005)

	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED
