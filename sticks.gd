extends AnimatedSprite2D

@export var right = ""
@export var left = ""
@export var up = ""
@export var down = ""

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed(right):
		animation = "right"
	elif Input.is_action_pressed(left):
		animation = "left"
	elif Input.is_action_pressed(down):
		animation = "down"
	elif Input.is_action_pressed(up):
		animation = "up"
	else:
		if animation != "cycle":
			animation = "default"

func _ready() -> void:
	play("cycle")


func _on_program_container_program_started() -> void:
	animation = "cycle"
