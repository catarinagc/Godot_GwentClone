extends CharacterBody2D

enum cardTypeEnum {Base, Seige, Ranged, Close};
@export var cardType: int;
@export var points: int;
@export var isPlayer1Card: bool;
var mouseInCard = false;
var mouseClick = false;
var lastPosition;
var onTopOfField = false;
var field;
signal changeScore(val)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lastPosition = global_position;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if mouseClick && mouseInCard:
		position = get_global_mouse_position()

func _on_mouse_entered() -> void:
	print_debug("mouse in")
	mouseInCard = true;

func _unhandled_input(event):
	if(is_connected("mouse_entered",_on_mouse_entered)):
		if event is InputEventMouseButton:
			mouseClick = !mouseClick
		if(!mouseClick):
			if(onTopOfField):
				lastPosition = position;
				disconnect("mouse_entered",_on_mouse_entered);
				#self.get_parent().remove_child(self)
				#field.add_child(self)
				self.changeScore.connect(field.addScore);
				emit_signal("changeScore", points);
			else:
				global_position = lastPosition;

func _on_mouse_exited() -> void:
	if(!mouseClick):
		mouseInCard = false

func _on_card_field_card_on_field(value) -> void:
	print_debug("here")
	onTopOfField = true;
	field = value;

func _on_card_field_card_off_field() -> void:
	if(is_connected("mouse_entered",_on_mouse_entered)):
		print_debug("wtf")
		onTopOfField = false;
		field = null;
