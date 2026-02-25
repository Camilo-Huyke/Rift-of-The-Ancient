extends Node3D

@export var spawn_points: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ServerManager.player_loaded.rpc_id(1)
	
func start_game():
	if multiplayer.is_server():
		_spawn_players()
		
func _spawn_players():
	var counter: int = 0
	var list_point = spawn_points.get_children()
	for id in ServerManager.players:
		var p = preload("res://scenes/simple_character.tscn").instantiate()
		p.name = str(id)
		counter += 1
		add_child(p, true)
		p.global_position = list_point[counter].global_position
