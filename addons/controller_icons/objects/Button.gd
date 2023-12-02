@tool
extends Button
class_name ControllerButton

## Name of the input action that you wish to display
@export var path : String = "":
	set(_path):
		path = _path
		if is_inside_tree():
			if force_type > 0:
				icon = ControllerIcons.parse_path(path, force_type - 1)
			else:
				icon = ControllerIcons.parse_path(path)

## When set to Keyboard/Mouse or Controller,
## the object will hide when the opposite input method is used.
@export_enum("Both", "Keyboard/Mouse", "Controller") var show_only : int = 0:
	set(_show_only):
		show_only = _show_only
		_on_input_type_changed(ControllerIcons._last_input_type)

## When set to other than None,
## forces the displayed icon to be either Keyboard/Mouse or Controller.
## Only relevant for input actions, other types of lookup paths are not affected by this.
@export_enum("None", "Keyboard/Mouse", "Controller") var force_type : int = 0:
	set(_force_type):
		force_type = _force_type
		_on_input_type_changed(ControllerIcons._last_input_type)

## Which joypad to check for inputs
@export var joypad_index: ControllerIcons.JoypadIndex

func _ready():
	ControllerIcons.input_type_changed.connect(_on_input_type_changed)
	self.path = path

func _on_input_type_changed(input_type):
	if show_only == 0 or \
		(show_only == 1 and input_type == ControllerIcons.InputType.KEYBOARD_MOUSE) or \
		(show_only == 2 and input_type == ControllerIcons.InputType.CONTROLLER):
		self.path = path
	else:
		icon = null

func get_tts_string() -> String:
	if force_type:
		return ControllerIcons.parse_path_to_tts(path, force_type - 1)
	else:
		return ControllerIcons.parse_path_to_tts(path)
