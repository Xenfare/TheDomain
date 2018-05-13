///save(filename (optional))

//first update progress map (may not be needed if map is updated on changes)
global.progress[?"current room"] = player.checkroom
global.progress[?"has checkpoint"] = instance_exists(player.checkpoint)
if global.progress[?"has checkpoint"]
{
    global.progress[?"checkpoint x"] = player.checkpoint.x
    global.progress[?"checkpoint y"] = player.checkpoint.y
}

//save to file
if argument_count = 0
    var fname = "save.sav"
else
    var fname = argument[0]
var f = file_text_open_write(fname)
if f = -1
{
    show_debug_message("Error saving to fine: " + fname)
    return 0
}
file_text_write_string(f, ds_map_write(global.progress))
file_text_close(f)
return 1
