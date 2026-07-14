extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const ATTACK_OFFSET = 190.0
var sprint = 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		$AnimationPlayer.play("Attack1")
	if event.is_action_pressed("sprint"):
		sprint = 2
	if event.is_action_released("sprint"):
		sprint = 1

func _ready():
	$Slashs.hide()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	handleFacingDirection(direction)
	determineAnimation()
	
	if direction:
		velocity.x = direction * SPEED * sprint
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func handleFacingDirection(direction: float):
	#facing left
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
		$Slashs.flip_h = true
		$Slashs.position.x = -ATTACK_OFFSET
	#facing right
	if direction > 0:
		$AnimatedSprite2D.flip_h = false
		$Slashs.flip_h = false
		$Slashs.position.x = ATTACK_OFFSET

func determineAnimation():
	if not is_on_floor():
		$AnimationPlayer.play("jump")
	elif Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		$AnimationPlayer.play("walk", -1, sprint)
	else:
		$AnimationPlayer.play("Idle")


func _on_slashs_animation_finished() -> void:
	$Slashs.hide()
