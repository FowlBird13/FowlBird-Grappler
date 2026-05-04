-- Utility function for getting paths concisely
rapi_sprite = function(identifier, filename, image_number, x_origin, y_origin) 
    local sprite_path = path.combine(PATH, "Sprites",  filename)
    return Sprite.new(identifier, sprite_path, image_number, x_origin, y_origin)
end
rapi_sound = function(id, filename)
    local sound_path = path.combine(PATH, "Sounds", filename)
    return Sound.new(id, sound_path)
end