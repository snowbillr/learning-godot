extends Polygon2D

var top_left := Vector2()
var top_right := Vector2()
var bottom_left := Vector2()
var bottom_right := Vector2()

var initial_points = {}
var tweens = {}

func _ready():
	initial_points["top_left"] = polygon[0]
	initial_points["top_right"] = polygon[1]
	initial_points["bottom_right"] = polygon[2]
	initial_points["bottom_left"] = polygon[3]
	
	tweens["top_left"] = $TopLeftTween
	tweens["top_right"] = $TopRightTween
	tweens["bottom_right"] = $BottomRightTween
	tweens["bottom_left"] = $BottomLeftTween
	
	top_left = polygon[0]
	top_right = polygon[1]
	bottom_right = polygon[2]
	bottom_left = polygon[3]
	
	_tween_point("top_left")
	_tween_point("top_right")
	_tween_point("bottom_right")
	_tween_point("bottom_left")
	
	
func _tween_point(prop):
	var displaced_point = _get_displaced_point(initial_points.get(prop))
	var duration = rand_range(0.2, 0.4)
	var tween = tweens.get(prop)
	tween.interpolate_property(self, prop, null, displaced_point, duration, Tween.TRANS_LINEAR)
	tween.start()


func _get_displaced_point(anchor) -> Vector2:
	var x = rand_range(10, 30)
	var y = rand_range(10, 30)
	var x_sign = 1 if randf() < 0.5 else -1
	var y_sign = 1 if randf() < 0.5 else -1
	return anchor + Vector2(x * x_sign, y * y_sign)


func _on_AllTweens_tween_step(_a, _b, _c, _d):
	var updated = PoolVector2Array()
	updated.append(top_left)
	updated.append(top_right)
	updated.append(bottom_right)
	updated.append(bottom_left)
	
	polygon = updated


func _on_AllTweens_tween_completed(object, key):
	_tween_point(key.get_subname(0))
