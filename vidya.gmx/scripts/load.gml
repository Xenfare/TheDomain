///load(filename (optional))

//attempt to load from file
if argument_count = 0
    var fname = "save.sav"
else
    var fname = argument[0]
var f = file_text_open_read(fname)
if f = -1
{
    show_debug_message("Error reading from fine: " + fname)
    return 0
}
ds_map_read(global.progress,file_text_read_string(f))
file_text_close(f)


if !(player.checkroom == global.progress[?"current room"] && player.checkroom == room && instance_exists(player.checkpoint) && global.progress[?"has checkpoint"] && 
global.progress[?"checkpoint x"] = player.checkpoint.x && global.progress[?"checkpoint y"] = player.checkpoint.y)
{
    player.checkroom = global.progress[?"current room"]
    if global.progress[?"has checkpoint"]
    {
        with(instance_create(global.progress[?"checkpoint x"],global.progress[?"checkpoint y"],spawnpoint))
        {
            myroom = player.checkroom
            player.checkpoint = id
        }
    }
    else
        player.checkpoint = noone 
}

player.alive = false
room_goto(player.checkroom)

return 1
