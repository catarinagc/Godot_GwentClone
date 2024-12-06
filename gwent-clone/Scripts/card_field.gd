extends Area2D

var amountOfPoints = 0;
@export var isPlayer1Field: bool;
enum fieldTypeEnum {Base, Seige, Ranged, Close};
@export var fieldType: int;
signal cardOnField(emitter);
signal cardOffField;
var Card = preload("res://Scenes/card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(fieldType == 0):
		createCards(1);
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if(body.cardType == 0 || body.cardType == fieldType):
		self.cardOnField.connect(body._on_card_field_card_on_field);
		emit_signal("cardOnField", self);

func _on_body_exited(body: Node2D) -> void:
	if(body.cardType == 0 || body.cardType == fieldType):
		self.cardOffField.connect(body._on_card_field_card_off_field);
		emit_signal("cardOffField");
		
func addScore(val:int) -> void:
	amountOfPoints += val;
	print_debug(amountOfPoints)
	
func createCards(amount:int) -> void:
	print_debug("chegou ao metodo")
	for i in range(amount):
		var Card_instance =  Card.instantiate()
		Card_instance.points = 2; ##make range
		##choose rand type
		get_tree().get_root().call_deferred("add_child", Card_instance)
		Card_instance.global_transform = get_parent().global_transform
