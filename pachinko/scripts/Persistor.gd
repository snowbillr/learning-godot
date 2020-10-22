extends Reference

class_name Persistor

const SAVE_FILE_PATH = "user://saveFile.sv"

func save_high_score(score) -> void:
    var saveFile = File.new()
    saveFile.open(SAVE_FILE_PATH, File.WRITE)
    saveFile.store_line(to_json({ "score": score }))
    saveFile.close()

func load_high_score() -> int:
    var saveFile = File.new()
    if !saveFile.file_exists(SAVE_FILE_PATH):
        return 0

    saveFile.open(SAVE_FILE_PATH, File.READ)
    var rawSaveData = saveFile.get_line()
    var saveData = parse_json(rawSaveData)
    saveFile.close()
    return saveData["score"]
