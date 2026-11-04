extends Node2D
class_name Interactable

signal interacted(player: Player)

@export var interaction_text: String = "Press [Action] to interact"

# This function will be overridden by specific types (NPC, Chest, etc.)
func interact(player: Player) -> void:
	interacted.emit(player)
