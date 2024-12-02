extends Node

## Clase que hace daño instantáneo al personaje principal
##
## Al entrar en contacto con este objeto, el personaje pierde toda la vida de inmediato y se reinicia la escena.

@onready var _player_script: Node2D # Referencia al script del jugador

# Función que se ejecuta cuando un cuerpo entra en el área de colisión
func _on_area_body_entered(body):
	if body.is_in_group("player"):  # Asegúrate de que tu personaje esté en el grupo "player"
		# Obtenemos el nodo del script del jugador
		_player_script = body.get_node("MainCharacterMovement")
		# Hacemos que el jugador reciba un daño mortal
		_player_script.hit(100)  # Ajusta el valor de daño si es necesario
		print("¡El jugador ha sido eliminado!")

		# Reiniciamos la escena inmediatamente después de que el jugador haya sido eliminado
		get_tree().reload_current_scene()


# Función que se ejecuta cuando un cuerpo sale del área de colisión
func _on_area_body_exited(body):
	# Si es el jugador, reseteamos la referencia del script del jugador
	if body.is_in_group("player"):
		_player_script = null
