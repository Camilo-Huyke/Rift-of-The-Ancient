extends Control

@onready var host_button: Button = $VBoxContainer/Host
@onready var join_button: Button = $VBoxContainer/Join


func _on_host_pressed() -> void:
	ServerManager.create_game()


func _on_join_pressed() -> void:
	ServerManager.join_game()
