extends Control

@onready var main_container : VBoxContainer = $VBoxContainer
@onready var host_button: Button = $VBoxContainer/Host
@onready var join_button: Button = $VBoxContainer/Join
@onready var ip_line: LineEdit = $VBoxContainer/IPAddress

@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var players_container: VBoxContainer = $ScrollContainer/PlayersContainer

@onready var start_button: Button = $StartButton

func _ready() -> void:
	ServerManager.player_connected.connect(_on_player_list_changed)
	ServerManager.server_disconnected.connect(_on_server_disconnected)
	
	scroll_container.hide()
	start_button.hide()
	
func _on_host_pressed() -> void:
	var error = ServerManager.create_game()
	if error:
		return
		
	main_container.hide()
	scroll_container.show()
	start_button.show()
	
func _on_join_pressed() -> void:
	var error = ServerManager.join_game(ip_line.text)
	if error:
		return
	
	main_container.hide()
	scroll_container.show()

func _on_player_list_changed(_id, _info) -> void:
	for child in players_container.get_children():
		child.queue_free()
	
	for p_id in ServerManager.players:
		var info = ServerManager.players[p_id]
		var label = Label.new()
		label.text = info["name"]
		players_container.add_child(label)
		
func _on_server_disconnected():
	for child in players_container.get_children():
		child.queue_free()
		
	main_container.show()
	scroll_container.hide()
	start_button.hide()
	
