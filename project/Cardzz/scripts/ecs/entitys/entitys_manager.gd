extends Node

const entity_type = preload("entity.gd")

signal add_entity(entity)
signal remove_entity(entity)

func get_entities():
	return get_children()

func get_entities_with_components(component_types):
	var entities = []
	for child in get_children():
		if(child.has_components(component_types)):
			entities.append(child)
	return entities;

func add_entity(entity_name,components):
	var entity = entity_type.new()
	for component in components:
		entity.add_component(component)
	add_child(entity)
	emit_signal("add_entity",entity)
	entity.emit_signal("added")
	return entity

func remove_entity(entity):
	entity.emit_signal("removed")
	emit_signal("remove_entity",entity)
	entity.queue_free()