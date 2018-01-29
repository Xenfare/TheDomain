///dialog_goto_label(dialog,label)
if !ds_exists(argument0,ds_type_map)
    return false
var list = argument0[? "list"]
if !ds_exists(list,ds_type_list)
    return false
for(var i = 0; i < ds_list_size(list) - 1; ++i)
    if list[| i] = -1 && list[| i + 1] = argument1
    {
        argument0[? "list position"] = i + 2
        return true
    }
return false;
