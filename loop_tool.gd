extends Line2D

const MINIMUM_DISTANCE_BETWEEN_POINTS = 0.5

var maximum_line_length = 2000
var mana_cost_per_length = 0.01

@export var player: Player

func _process(delta):
    if Input.is_action_pressed("left_mouse_click"):
        if player.mana:
            if not points.size():
                add_point(get_local_mouse_position())
            else:
                if is_required_segment_length_obtained():
                    add_point(get_local_mouse_position())
                    var new_start = get_point_position(points.size() - 2)
                    var new_end = get_point_position(points.size() - 1)
                    add_collision_to_segment(new_start, new_end)
                    if points.size() >= 4:  # Need at least 2 segments to check
                        check_loop_formation(new_start, new_end)
                    if player:
                        var added_length = new_end.distance_to(new_start)
                        player.mana -= mana_cost_per_length * added_length
                    while get_total_line_length() >= maximum_line_length:
                        remove_point_and_collision(0)
    if Input.is_action_just_released("left_mouse_click"):
        clear_line()

func remove_point_and_collision(index):
    remove_point(index)
    %CollisionArea.get_child(index).queue_free()

func check_loop_formation(new_start: Vector2, new_end: Vector2):
    for i in range(points.size() - 3):
        var old_start = get_point_position(i)
        var old_end = get_point_position(i + 1)
        if are_segments_crossing_each_other([old_start, old_end], [new_start, new_end]):
            var polygon = points.duplicate()
            check_enemies_inside_polygon(polygon) #Not optimized
            clear_line()

func is_required_segment_length_obtained() -> bool:
    var mouse_position = get_global_mouse_position()
    var last_point: Vector2 = get_point_position(points.size() - 1)
    if mouse_position != last_point:
        if mouse_position.distance_to(last_point) > MINIMUM_DISTANCE_BETWEEN_POINTS:
            return true
    return false

func are_segments_crossing_each_other(segment_1: PackedVector2Array, segment_2: PackedVector2Array):
    var x1 = segment_1[0].x
    var x2 = segment_1[1].x
    var y1 = segment_1[0].y
    var y2 = segment_1[1].y
    var x3 = segment_2[0].x
    var x4 = segment_2[1].x
    var y3 = segment_2[0].y
    var y4 = segment_2[1].y
    if (max(x1, x2) < min(x3, x4)):
        return false #No mutual abscissa
    if (x1 == x2) or (x3 == x4):
        return false
    var a1 = (y1-y2)/(x1-x2)
    var a2 = (y3-y4)/(x3-x4)
    var b1 = y1-a1*x1
    var b2 = y3-a2*x3
    if (a1 == a2):
        return false #parallel segments
    var xa = (b2 - b1) / (a1 - a2)
    if ((xa < max(min(x1, x2), min(x3, x4))) or (xa > min(max(x1, x2), max(x3, x4)))):
        return false
    else:
        return true

func get_total_line_length() -> float:
    var length = 0.0
    if points.size() > 1:
        for i in range(points.size() - 1):
            var a = get_point_position(i)
            var b = get_point_position(i + 1)
            length += a.distance_to(b)
    return length

func check_enemies_inside_polygon(polygon_points: PackedVector2Array) -> void:
    var enemies = get_tree().get_nodes_in_group("enemy")
    for enemy in enemies:
        if enemy.has_method("get_global_position"):
            var global_pos = enemy.get_global_position()
            var local_pos = to_local(global_pos)
            if is_point_inside_polygon(local_pos, polygon_points):
                enemy.health -= 100
                player.coins += enemy.coins

func is_point_inside_polygon(point: Vector2, polygon: PackedVector2Array) -> bool:
    var inside = false
    var j = polygon.size() - 1
    for i in range(polygon.size()):
        var pi = polygon[i]
        var pj = polygon[j]
        if ((pi.y > point.y) != (pj.y > point.y)):
            var x_intersect = (pj.x - pi.x) * (point.y - pi.y) / (pj.y - pi.y + 0.0001) + pi.x
            if (point.x < x_intersect):
                inside = !inside
        j = i
    return inside

func add_collision_to_segment(last_point: Vector2, new_point: Vector2):
    var new_shape = CollisionShape2D.new()
    %CollisionArea.add_child(new_shape)
    var rect = RectangleShape2D.new()
    new_shape.position = (last_point + new_point) / 2
    new_shape.rotation = last_point.direction_to(new_point).angle()
    var length = last_point.distance_to(new_point)
    rect.extents = Vector2(length / 2, 10)
    new_shape.shape = rect

func clear_children(parent):
    for child in parent.get_children():
        child.queue_free()

func clear_line():
    clear_points()
    clear_children(%CollisionArea)

func _on_loop_tool_area_entered(area: Area2D) -> void:
    if area.is_in_group("loop_stopper"):
        clear_line()
    if area.is_in_group("projectile") and player:
        player.take_damage(area)
        area.queue_free()
        
func _on_loop_tool_body_entered(body: Node2D) -> void:
    if body.is_in_group("loop_stopper"):
        clear_line()
