var maxh = ds_grid_width(global.wall_grid)
var size_cuttoff = maxh * maxh
var g = ds_grid_create(maxh,maxh)
ds_grid_copy(g, global.wall_grid)

ds_list_clear(global.light_objects)

var left, right, top, bottom;
var ind = 1;
for(var ii = 0; ii < maxh; ++ii)
for(var i = 0; i < maxh; ++i)
{
    if g[# i, ii] = 1
    {
        ++ind;
        left = i;
        right = left;
        top = ii;
        bottom = top;
        for(var xx = i + 1; xx < maxh; ++xx)
            if !g[# xx, top]
            {
                right = xx - 1;
                i = right
                break;
            }
        for(var yy = ii + 1; yy < maxh; ++yy)
        {
            var xxx = left;
            var last_start = xxx;
            var early_exit = false;
            for(; xxx <= right; ++xxx)
                if !g[# xxx, yy] 
                {
                    if last_start != -1{
                    bottom = yy - 1;
                    if xxx != left
                    { 
                        if last_start - xxx - 1 > 1 || (last_start > 0 && g[# last_start - 1, yy])
                        ds_list_add(global.light_objects,last_start,bottom,xxx - 1,yy);
                    }
                    last_start = -1;
                    early_exit = true}
                }
                else if last_start = -1
                   last_start = xxx;
            if early_exit
            {
                if last_start != -1 && last_start - right > 1 || (last_start < maxh - 1 && g[# last_start + 1, yy])
                    ds_list_add(global.light_objects,last_start,bottom,right,yy);
                break;
            }
        }
        //check to see if it needs to back up
        var potential_left = left - 1;
        var potential_left_val = g[# potential_left, top]
        if potential_left_val != 0
        {
            var yy = top;
            for(; yy <= bottom; ++yy)
            {
                if potential_left_val != g[# potential_left, yy]
                {
                    break;
                }
            }
            if yy > bottom
            {
                left = potential_left
                
            }
        }
        var potential_top = top - 1;
        var potential_top_val = g[# left, potential_top]
        if potential_top_val != 0
        {
            var xx = left;
            for(; xx <= right; ++xx)
            {
                if potential_top_val != g[# xx, potential_top]
                {
                    break;
                }
            }
            if xx > right
                top = potential_top
        }
        //show_debug_message(string(left) + "," + string(top) + "," + string(right) + "," + string(bottom));
        ds_grid_set_region(g, left, top, right, bottom, ind);
        ds_list_add(global.light_objects,left,top,right,bottom);
    }
}

//2nd pass to block holes
/*
for(var ii = 0; ii < maxh - 1; ++ii)
{
//var str = ""
for(var i = 0; i < maxh - 1; ++i)
{
    var basec = g[# i, ii]
    if basec != 0
    {
        var rightc = g[# i + 1, ii]
        var downc = g[# i, ii + 1]
        if rightc != 0 && basec != rightc
            ds_list_add(global.light_objects,i,ii,i + 1,ii);
        if downc != 0 && basec != downc
            ds_list_add(global.light_objects,i,ii,i,ii + 1);
    }
    //if (i >= BUFFER_CELLS && ii >= BUFFER_CELLS)
    //str += "," + string(basec)
}
    //show_debug_message(str)
}*/

ds_grid_destroy(g)
