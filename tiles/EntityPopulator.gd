extends TileMap

var emitter_node = preload("res://entities/emitter/emitter.tscn")

onready var emitter = $"../emitter"
onready var drains = $"../drains"

func _ready():
	#Gets coordinates (x, y) of all used cells 
	var cells = get_used_cells()

	#Clear all the existing tiles

	#Loop through all the cells, spawn the preloaded object, make it tilemap's child
	#and reposition it to wherever the cell was before.
	for cell in cells:
		var cell_type = get_cellv(cell)
		var position = Vector2(cell.x * cell_size.x + cell_size.x / 2, cell.y * cell_size.y + cell_size.y / 2)

		match cell_type:
			4: 
				var new_emitter = emitter_node.instance()
				new_emitter.global_position = position
				emitter.add_child(new_emitter)
			5: 
				print("Drain")
			
	clear()
		
