extends Label
var colors = [Color.RED, 
Color.ORANGE, 
Color.YELLOW, 
Color.GREEN, 
Color.AQUA, 
Color.BLUE, 
Color.PURPLE]

var transparency = 1.0

func _ready() -> void:
	text = "+ " + str(GameData.clickpower)
	modulate = colors[GameData.color_index]
	GameData.color_index = (GameData.color_index + 1) % colors.size()
	
	
func _process(delta: float) -> void:
	var tween = create_tween()
	tween.tween_property(self, "position:y", self.position.y - 50, 1.0) # rise
	tween.parallel().tween_property(self, "modulate:a", 0.0, 1.0)      # fade
	tween.tween_callback(self.queue_free)
	
