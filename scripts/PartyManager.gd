extends Node

# PartyManager Manager (Singleton)
# Manages the active party members and their stats.

signal party_changed
signal member_died(member_name)

@export var starting_party_size: int = 1

var party: Array[CharacterData] = []

func _ready() -> void:
	pass

func add_to_party(character: CharacterData) -> void:
	party.append(character)
	party_changed.emit()

func remove_from_party(index: int) -> void:
	if index >= 0 and index < party.size():
		var member = party[index]
		party.remove_at(index)
		member_died.emit(member.name)
		party_changed.emit()

func get_total_hp() -> int:
	var total = 0
	for member in party:
		total += member.max_hp
	return total
