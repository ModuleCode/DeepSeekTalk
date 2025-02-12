@tool
extends EditorImportPlugin

func _get_priority():
	return 0

func _get_importer_name():
	return "moc3.importer"
	
func _get_visible_name():
	return "moc3"

# 支持的文件类型
func _get_recognized_extensions():
	return ["moc3","version"]

func _get_save_extension():
	return "moc3"

func _get_resource_type():
	return "moc3"
	
