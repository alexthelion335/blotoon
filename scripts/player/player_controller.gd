extends CharacterBody3D

@export var move_speed: float = 7.0
@export var sprint_speed: float = 12.0
@export var acceleration: float = 25.0
@export var friction: float = 20.0
@export var jump_force: float = 5.5
@export var gravity: float = 12.0

var is_sprinting: bool = false
var camera_controller: Node3D

func _ready() -> void:
	camera_controller = $Camera3D
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	var input_x = 0.0
	var input_z = 0.0
	
	if Input.is_key_pressed(KEY_W):
		input_z += 1.0
	if Input.is_key_pressed(KEY_S):
		input_z -= 1.0
	if Input.is_key_pressed(KEY_A):
		input_x -= 1.0
	if Input.is_key_pressed(KEY_D):
		input_x += 1.0
	
	var input_dir = Vector2(input_x, input_z).normalized()
	is_sprinting = Input.is_key_pressed(KEY_SHIFT)
	
	var target_speed = sprint_speed if is_sprinting else move_speed
	
	var angle = rotation.y
	var forward = Vector3(sin(angle), 0, -cos(angle))
	var right = Vector3(cos(angle), 0, sin(angle))
	var direction = (forward * input_dir.y + right * input_dir.x).normalized()
	
	if direction.length() > 0:
		velocity.x = lerp(velocity.x, direction.x * target_speed, acceleration * delta)
		velocity.z = lerp(velocity.z, direction.z * target_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
		velocity.z = lerp(velocity.z, 0.0, friction * delta)
	
	if is_on_floor():
		if Input.is_key_pressed(KEY_SPACE):
			velocity.y = jump_force
		else:
			velocity.y = 0.0
	else:
		velocity.y -= gravity * delta
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.005)
		if camera_controller:
			camera_controller.rotate_camera(event.relative.y * 0.005)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED
