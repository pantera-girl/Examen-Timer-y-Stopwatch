extends CanvasLayer

var is_timer = true

var minutes = 0
var seconds = 0
var decimals = 0 

func _on_ready():
	$ModeLabel.text = 'TIMER'

func update_label():
	$DecLabel.text = str(decimals)
	$TimerLabel.text = '%02d:%02d'%[minutes,seconds]


func _on_mode_button_pressed():
	if $Timer.is_stopped(): 
		minutes = 0
		seconds = 0
		decimals = 0 
		is_timer = !is_timer
	if is_timer == true:
		$ModeLabel.text = 'TIMER'
	else:
		$ModeLabel.text = 'STOPWATCH'
		update_label()

func _on_start_button_pressed():
	
	if $Timer.is_stopped():
		$Timer.start(0.1)
		$StateLabel.text = 'RUNNING'
	else:
		$Timer.stop()
		$StateLabel.text = 'STOPPED'

func update_stopwatch(): 
	decimals += 1
	if decimals >= 10:
		decimals = 0
		seconds += 1
	if seconds >= 60:
		seconds = 0
		minutes += 1
	if minutes >= 59:
		seconds = 59
		minutes = 59
		decimals = 9
		$StateLabel.text = 'STOPPED'
		$Timer.stop()
		# $StopSound.play()
	update_label()

func update_timer():
	decimals -= 1
	if decimals < 0:
		decimals = 9
		seconds -= 1
	if seconds < 0:
		seconds = 59
		minutes -= 1
	if minutes < 0:
		minutes = 0
		seconds = 0
		decimals = 0
		$StateLabel.text = 'STOPPED'
		$Timer.stop()
		$StopSound.play()
	update_label()
	


func _on_timer_timeout():
	if is_timer == false:
		update_stopwatch()
	else:
		update_timer()

func _on_seconds_button_pressed():
	if $Timer.is_stopped() and is_timer == true: 
		seconds += 1
		if seconds > 59:
			seconds = 0
		decimals = 0
		update_label()

func _on_add_min_button_pressed():
	if $Timer.is_stopped() and is_timer == true:
		minutes += 1
	if minutes > 59:
		minutes = 0
	decimals = 0
	update_label()

func _on_reset_button_pressed():
	if $Timer.is_stopped():
		minutes = 0
		seconds = 0
		decimals = 0 
		update_label()
		
