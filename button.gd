extends AnimatedSprite2D

@export var pressed = ""

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed(pressed):
		animation = "pressed"
	else:
		if animation != "cycle":
			animation = "unpressed"

func _ready() -> void:
	play("cycle")


func _on_program_container_program_started() -> void:
	animation = "cycle"
