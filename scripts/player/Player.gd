extends CharacterBody2D

class_name Player

@export var stats: CharacterData
@export var tile_size: int = 16

var is_moving: bool = false
var input_direction: Vector2 = Vector2.ZERO

# The single RayCast used for both collision and interaction
@onready var raycast: RayCast2D = $RayCast2D

func _ready() -> void:
	if not stats:
		stats = CharacterData.new()
	print("Player initialized as: ", stats.name)
	
	if raycast:
		raycast.enabled = true

func _physics_process(_delta: float) -> void:
	# 1. Handle Movement Input
	if is_moving:
		return

	var move_vec = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if move_vec != Vector2.ZERO:
		# Strict cardinal movement for grid-based feel
		if abs(move_vec.x) > abs(move_vec.y):
			input_direction = Vector2(sign(move_vec.x), 0)
		else:
			input_direction = Vector2(0, sign(move_vec.y))
		
		if can_move() -> bool:
			move_player()

	# 2. Handle Interaction Input (e.g., Space or Enter)
	if Input.is_action_just_pressed("ui_accept"):
		attempt_interaction()

func can_move() -> bool:
	if not raycast: return true
	
	raycast.target_position = input_direction * tile_size
	raycast.force_raycast_update()
	
	# If colliding, we cannot move (it's a wall)
	return !raycast.is_colliding()

func attempt_interaction() -> void:
	if not raycast or not raycast.is_colliding():
		return

	var collider = raycast.get_collider()
	
	# Check if the object we hit is an Interactable (or inherits from it)
	if collider is Interactable:
		collider.interact(self)
	elif collider.get_parent() is Interactable:
		# Sometimes the RayCast hits a child collision shape, so check parent
		collider.get_parent().interact(self)

func move_player() -> void:
	var target_position = position + input_direction * tile_size
	is_moving = true
	
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, 0.15).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(func(): is_moving = false)

