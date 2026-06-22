extends RigidBody3D

@export var gravity: float = 9.8
@export var lifetime: float = 5.0
@export var radius: float = 0.35

var velocity: Vector3 = Vector3.ZERO
var ink_color: Color = Color.BLUE
var time_alive: float = 0.0

func _ready() -> void:
	gravity_scale = 0
	if $Mesh:
		var mesh_instance = $Mesh
		var material = StandardMaterial3D.new()
		material.albedo_color = ink_color
		mesh_instance.set_surface_override_material(0, material)

func _process(delta: float) -> void:
	time_alive += delta
	if time_alive > lifetime:
		queue_free()
	
	velocity.y -= gravity * delta
	global_position += velocity * delta

func set_velocity(vel: Vector3) -> void:
	velocity = vel

func set_ink_color(color: Color) -> void:
	ink_color = color
	if $Mesh:
		var material = StandardMaterial3D.new()
		material.albedo_color = color
		$Mesh.set_surface_override_material(0, material)

func hit_ground() -> void:
	queue_free()
