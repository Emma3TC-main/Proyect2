extends Camera2D

# Referencia al personaje principal
@export var character: CharacterBody2D

# Función de inicialización
func _ready():
	if not character:
		set_physics_process(false)
		return
	# Posicionamos la cámara en la posición inicial del personaje
	position = character.position


# Función de ejecución de físicas
func _physics_process(delta):
	if not character:
		return

	# Interpolación para suavizar el movimiento
	var charpos = character.position
	var new_pos = position.lerp(charpos, delta * 2.0)
	new_pos.x = int(new_pos.x)
	new_pos.y = int(new_pos.y)
	position = new_pos
