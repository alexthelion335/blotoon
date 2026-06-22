extends Node3D

@export var projectile_scene: PackedScene
@export var fire_rate: float = 0.15
@export var projectile_speed: float = 20.0
@export var max_ammo: int = 100
@export var ink_color: Color = Color.BLUE

var current_ammo: int
var fire_cooldown: float = 0.0

func _ready() -> void:
	current_ammo = max_ammo

func _process(delta: float) -> void:
	if fire_cooldown > 0:
		fire_cooldown -= delta

func fire() -> void:
	if fire_cooldown > 0 or current_ammo <= 0:
		return
	
	if projectile_scene:
		var projectile = projectile_scene.instantiate()
		get_tree().root.add_child(projectile)
		
		var parent = get_parent()
		var camera = parent.get_node("Camera3D")
		
		var spawn_pos = parent.global_position + Vector3(0, 0.8, 0)
		var fire_direction = -camera.global_transform.basis.z
		
		projectile.global_position = spawn_pos
		projectile.set_velocity(fire_direction * projectile_speed)
		projectile.set_ink_color(ink_color)
		
		current_ammo -= 1
		fire_cooldown = fire_rate

func add_ammo(amount: int) -> void:
	current_ammo = min(current_ammo + amount, max_ammo)

func get_ammo_percent() -> float:
	return float(current_ammo) / float(max_ammo)
