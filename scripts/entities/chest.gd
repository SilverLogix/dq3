extends Interactable

@export var item_name: String = "Potion"
var is_opened: bool = false

func interact(player: Player) -> void:
	if not is_opened:
		is_opened = true
		print("You found a ", item_name, "! (Added to inventory)")
		# Later we will call InventoryManager.add_item(...)
	else:
		print("The chest is already empty.")
