extends Node2D

var BoonConnector = preload("res://scenes/BoonConnector.tscn")

func _ready() -> void:
    var boons = $Boons.get_children()

    for boon in boons:
        boon = boon as Boon
        var dependencies = boon.boon_data.dependencies as Array
        if dependencies.size() > 0:
            for orDependencies in dependencies:
                print(orDependencies)
                for orDependency in orDependencies:
                    var prereq_boon = _find_boon(boons, orDependency)
                    _create_connector(boon, prereq_boon)



#    var connector = BoonConnector.instance()
#    connector.boon_1 = boons[0]
#    connector.boon_2 = boons[1]
#    add_child(connector)
func _find_boon(boons, boon_id) -> Boon:
    for boon in boons:
        if boon.boon_data.id == boon_id:
            return boon

    return null

func _create_connector(boon_1, boon_2) -> void:
    var connector = BoonConnector.instance()
    connector.boon_1 = boon_1
    connector.boon_2 = boon_2
    add_child(connector)
