extends ParallaxBackground

@onready var lava_layer = $ParallaxLayer_Lava

func _ready():
	# Inicialmente hacemos invisible la lava
	lava_layer.visible = false

	# Luego hacemos visible la lava cuando haya llegado a la posición deseada
	if position.x >= 1000:  # Cambia esto a la condición de cuando quieres que aparezca
		lava_layer.visible = true
