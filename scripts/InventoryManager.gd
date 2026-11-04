extends Node

# InventoryManager Manager (Singleton)
# Manages gold and items for the player/party.

signal gold_changed(new_amount)
signal item_received(item_name, amount)

@export var starting_gold: int = 50

var current_gold: int = 0:
	set(value):
		current_gold = value
		gold_changed.emit(current_gold)

func _ready() -> void:
	current_gold = starting_gold

func add_gold(amount: int) -> void:
	current_gold += amount

func subtract_gold(amount: int) -> bool:
	if current_gold >= amount:
		current_gold -= amount
		return true
	else:
		print("Not enough gold!")
		return false

func add_item(item_name: String, amount: int = 1) -> void:
	# Logic for adding items to a global inventory would go here
	item_received.emit(item_name, amount)
