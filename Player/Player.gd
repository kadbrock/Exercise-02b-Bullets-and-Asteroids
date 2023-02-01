extends KinematicBody2D

var velocity = Vector2.ZERO

var rotation_speed = 5.0
var speed = 5.0
var max_speed = 400.0
var nose = Vector2(0, -60)
onready var Bullet = load("res://Player/Bullet.tscn")

func get_input():
  var to_return = Vector2.ZERO
  $Exhaust.hide()
  if Input.is_action_pressed("forward"):
	to_return += Vector2(0,-1)
  	$Exhaust.show()
  if Input.is_action_pressed("left"):
  	rotation_degrees -= rot_speed
  if Input.is_action_pressed("right"):
  	rotation_degrees += rot_speed
  return to_return.rotated(rotation)

func _ready():
	pass

func _physics_process(_delta):
	velocity += get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	velocity = move_and_slide(velocity, Vector2.ZERO)
	position.x = wrapf(position.x, 0.0, 1024.0)
	position.y = wrapf(position.y, 0.0, 600.0)
	if Input.is_action_just_pressed("shoot"):
		var Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var bullet = Bullet.instance()
			bullet.rotation = rotation
			bullet.global_position = global_position + nose.rotated(rotation)
			Effects.add_child(bullet)
	
	$Exhaust.hide()
	if Input.is_action_pressed("forward"):
		velocity = velocity + Vector2(0,-speed).rotated(rotation)
		$Exhaust.show()
	if Input.is_action_pressed("left"):
		rotation_degrees = rotation_degrees - rotation_speed
	if Input.is_action_pressed("right"):
		rotation_degrees = rotation_degrees + rotation_speed
		
	position.x = wrapf(position.x, 0, 1024)
	position.y = wrapf(position.y, 0, 600)
