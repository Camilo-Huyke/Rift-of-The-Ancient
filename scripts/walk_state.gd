extends State

func update_physics(_delta:float):
	if is_multiplayer_authority() or str(multiplayer.get_unique_id()) == owner.name:
		if player:
			player.direction = (player.navigation_agent.get_next_path_position() - player.global_position).normalized()
			#print(player.direction, " ", player.navigation_agent.get_next_path_position(), " ", player.global_position)
			if player.navigation_agent.is_navigation_finished():
				player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
				player.velocity.z = move_toward(player.velocity.z, 0, player.speed)
				#player.animation_player.stop()
				transitioned.emit(self, "IdleState")
			else:
				player.velocity.x = player.direction.x * player.speed
				player.velocity.z = player.direction.z * player.speed
				#player.velocity = player.direction * player.speed
				#player.model.look_at(player.position + Vector3(-player.direction.x, 0, -player.direction.z), Vector3(0,1,0))
				var target_quaternion = Basis.looking_at(Vector3(-player.direction.x, 0, -player.direction.z)).get_rotation_quaternion()
				player.model.quaternion = player.model.quaternion.slerp(target_quaternion, 20 * _delta)
				#player.animation_player.play("Run")
				
			player.syn_velocity = player.velocity
				
			player.move_and_slide()
	else:
		if player.syn_velocity.length() > 0:
			player.velocity = player.syn_velocity
			var target_quaternion = Basis.looking_at(Vector3(-player.direction.x, 0, -player.direction.z)).get_rotation_quaternion()
			player.model.quaternion = player.model.quaternion.slerp(target_quaternion, 20 * _delta)
			#player.animation_player.play("Run")
			player.move_and_slide()
		else:
			player.velocity = Vector3.ZERO
			#transitioned.emit(self, "IdleState")
			
