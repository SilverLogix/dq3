extends Interactable

@export var dialogue_text: String = "Hello, traveler! Welcome to the world of DQ3."

func interact(player: Player) -> void:
	print("NPC says: ", dialogue_text)
	# Later we will hook this up to a real UI Dialogue Box
