extends GridContainer

var config = ConfigFile.new()
signal program_started

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#prevent mouse intrusion
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#setup grid
	config.load("programs.cfg")
	columns = config.get_value("Setup", "grid_columns")
	
	#setup buttons
	for i in range(config.get_sections().size()-1):
		var program := Button.new()
		
		program.text = config.get_value(str(i), "visible_name", "")
		program.icon = load(config.get_value(str(i), "icon", ""))
		
		match config.get_value(str(i), "icon_position", ""):
			"RIGHT":
				program.icon_alignment= HORIZONTAL_ALIGNMENT_RIGHT
			"CENTRE":
				program.icon_alignment= HORIZONTAL_ALIGNMENT_CENTER
		match config.get_value(str(i), "icon_mode", ""):
			"FILL":
				program.expand_icon = true
		
		program.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		program.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
		program.pressed.connect(_on_grid_button_pressed.bind(i))
		add_child(program)
		
		if i == 0:
			program.grab_focus()

func _on_grid_button_pressed(button_num) -> void:
	var command = config.get_value(str(button_num), "command")
	var args = config.get_value(str(button_num), "args", [])
	match command:
		"internal_exit":
			get_tree().quit()
		_:
			OS.execute(command, args)
	program_started.emit()
