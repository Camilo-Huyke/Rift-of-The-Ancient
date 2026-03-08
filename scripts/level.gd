extends Node3D

@export var spawn_points: Node3D
@export var players_container: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ServerManager.player_loaded.rpc_id(1)
	
func start_game():
	if multiplayer.is_server():
		_spawn_players()
	
func _spawn_players():
	var counter: int = 0
	var list_point = spawn_points.get_children()
	var p = preload("res://scenes/simple_character.tscn")
	for id in ServerManager.players:
		var _p = p.instantiate()
		_p.name = str(id)
		counter += 1
		players_container.add_child(_p, true)
		_p.global_position = list_point[counter].global_position
