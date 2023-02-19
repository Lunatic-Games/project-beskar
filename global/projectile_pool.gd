extends Node


var pools = {
	
}

func get_from_pool(packed_scene: PackedScene) -> Node:
	return packed_scene.instantiate()
