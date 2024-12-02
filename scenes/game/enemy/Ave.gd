extends CharacterBody2D

# Variables para controlar la velocidad y la gravedad
var _gravity = 10
var _speed = 110
var _target: Node2D
@onready var _animation := $AnimatedSprite2D  # Nodo de animación

# Variable para el daño
@export var damage = 1

# Referencia al área de colisión del enemigo
@onready var _hitbox = $Area2D  # Asegúrate de que este es el nodo Area2D

# Función de inicialización
func _ready():
	# Conectar la señal body_entered de Area2D correctamente
	_hitbox.body_entered.connect(_on_Hitbox_body_entered)  # Usamos la función directamente, sin el "self" como en Godot 3.x
	_target = get_tree().get_nodes_in_group("player")[0]
	if _target == null:
		print("Error: No se encontró el nodo 'MainCharacter'.")

func _physics_process(delta):
	apply_gravity()
	follow(delta)

# Aplica la gravedad a la velocidad vertical
func apply_gravity():
	velocity.y += _gravity

# Hace que el personaje siga al objetivo y se posicione 5 bloques por encima
func follow(delta):
	if _target != null:
		# Calcula la dirección hacia el jugador en el eje X
		var direction = position.direction_to(_target.position)
		velocity.x = direction.x * _speed  # Solo aplica la velocidad en el eje X

		# Ajusta la posición en Y, colocándolo 5 bloques por encima del objetivo
		position.y = _target.position.y - 5 * 16  # Asumiendo que 1 bloque es de 16px

		# Movimiento del personaje
		move_and_slide()

		# Control de la animación: Flip horizontal según la dirección
		if velocity.x < 0:
			_animation.flip_h = true
		elif velocity.x > 0:
			_animation.flip_h = false

		# Cambia la animación según el estado de movimiento
		if velocity.y != 0:
			_animation.play("default")  # Animación de salto
		elif velocity.x != 0:
			_animation.play("default")  # Animación de correr
		else:
			_animation.play("default")  # Animación de reposo

# Función que se llama cuando algo entra en contacto con la hitbox
func _on_Hitbox_body_entered(body):
	# Verificamos si el cuerpo que entró es el personaje
	if body.is_in_group("player"):  # Asegúrate de que tu personaje esté en el grupo "player"
		# Accedemos al script de movimiento del personaje para aplicar el daño
		var movement_script = body.get_node("MainCharacterMovement")
		movement_script.hit(damage)  # Llamamos al método hit() para infligir daño
		print("¡Daño infligido al personaje!")

