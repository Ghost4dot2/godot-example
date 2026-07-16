extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const ATTACK_OFFSET = 190.0
var sprint = 1
var combo = false
@onready var combo_timer = $Slashs/ComboTimer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		$AttackAnimations.play("Attack1")
	if event.is_action_pressed("sprint"):
		sprint = 2
	if event.is_action_released("sprint"):
		sprint = 1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimationPlayer.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	#$AnimationTree.set("parameters/BlendSpace1D/blend_position", direction)
	#$AnimationTree.set("parameters/blend_position", direction)
	#print(direction)
	#handleFacingDirection(direction)
	determineAnimation()
	
	if direction:
		velocity.x = direction * SPEED * sprint
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#if combo and not $Slashs.is_playing():
		#$AnimationPlayer.play("Attack2")
		#combo = false

	move_and_slide()
	#
#func handleFacingDirection(direction: float):
	##facing left
	#if direction < 0:
		#$AnimatedSprite2D.flip_h = true
		#$Slashs.flip_h = true
		#$Slashs.position.x = -ATTACK_OFFSET
	##facing right
	#if direction > 0:
		#$AnimatedSprite2D.flip_h = false
		#$Slashs.flip_h = false
		#$Slashs.position.x = ATTACK_OFFSET

func determineAnimation():
	if is_on_floor():
		if Input.is_action_pressed("Left"):
			$AnimationPlayer.play("walk_left", -1, sprint)
		elif Input.is_action_pressed("Right"):
			$AnimationPlayer.play("walk_right", -1, sprint)
		else:
			$AnimationPlayer.play("Idle")

func handleAttackDirection():
	$Slashs.flip_h = $AnimatedSprite2D.flip_h
	$Slashs.position.x = -ATTACK_OFFSET if $AnimatedSprite2D.flip_h else ATTACK_OFFSET
