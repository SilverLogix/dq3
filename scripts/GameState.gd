extends Node

# GameState Manager (Singleton)
# Handles high-level game flow and state transitions.

signal game_started(player_name)
signal player_died
signal world_state_changed(new_state)

enum WorldState { TITLE, WORLD_MAP, BATTLE, MENU, DIALOGUE }

var current_world_state: WorldState = WorldState.TITLE:
	set(value):
		current_world_state = value
		world_state_changed.emit(current_world_state)

func start_game(name: String) -> void:
	print("Starting game as: ", name)
	game_started.emit(name)
