///draw_lighting
var e_view_range = ceil(view_range/CELL_SIZE)
if surface_exists(lights)
{
    if surface_get_height(lights) != e_view_range * CELL_SIZE * 2
    {
        surface_free(lights)
        lights = surface_create(e_view_range * CELL_SIZE * 2, e_view_range * CELL_SIZE * 2)
    }
}
else
    lights = surface_create(e_view_range * CELL_SIZE * 2, e_view_range * CELL_SIZE * 2)

sub_grid = ds_grid_create(e_view_range * 2 + 4,e_view_range * 2 + 4)
var x_grid_offset = 0
var y_grid_offset = 0
/*if floor((x - e_view_range * CELL_SIZE) / CELL_SIZE) - 2 < 0
{
    x_grid_offset =abs(floor((x - e_view_range * CELL_SIZE) / CELL_SIZE) - 2)
    if x - e_view_range * CELL_SIZE < 0
    {
        x_grid_offset--
    }
}
if floor((y - e_view_range * CELL_SIZE) / CELL_SIZE) - 2 < 0
{
    y_grid_offset =abs(floor((y - e_view_range * CELL_SIZE) / CELL_SIZE) - 2)  
    if y - e_view_range * CELL_SIZE < 0
    {
        y_grid_offset--
    }
}*/
//show_debug_message(string(y/CELL_SIZE - e_view_range) + " " + string(e_view_range) + " " + string(round(view_range)))

ds_grid_set_grid_region(sub_grid,global.wall_grid,floor(x / CELL_SIZE) - e_view_range - 2,floor(y / CELL_SIZE) - e_view_range - 2,round((x + e_view_range * CELL_SIZE) / CELL_SIZE) + 2,round((y + e_view_range * CELL_SIZE) / CELL_SIZE) + 2,x_grid_offset,y_grid_offset)

var cells = e_view_range + 2

surface_set_target(lights)
draw_clear_alpha(c_black,0)
draw_set_blend_mode(bm_add)
draw_set_color(c_white)
draw_circle(e_view_range * CELL_SIZE,e_view_range * CELL_SIZE,view_range,0)
draw_set_color(c_black)
draw_set_blend_mode(bm_subtract)

var maxh = ds_grid_width(sub_grid) - 1
debug_str = ""
for(var ii = 0; ii <= maxh; ++ii)
for(var i = 1; i < maxh * .5; ++i)
{
    //check up area
    if sub_grid[# ii, cells - i]
    {
        debug_str = "up"
        var bottom = cells - i;
        var top = bottom;
        var left = ii, right = ii;
        while(--left >= 0 and sub_grid[# left, bottom]){}
        if (left < 0 or sub_grid[# left, bottom] != .5) ++left
        while(++right <= maxh and sub_grid[# right, bottom]){}
        if (right > maxh or sub_grid[# right, bottom] != .5) --right
        if (right < cells)
        {
            while(--top >= 0 and sub_grid[# right, top]){}
            if (top < 0 or sub_grid[# right, top] != .5) ++top
            var old_bottom = bottom
            while(++bottom <= maxh and sub_grid[# right, bottom]){}
            if (bottom > maxh or sub_grid[# right, bottom] != .5) --bottom
            if (bottom < cells) bottom = old_bottom
        }
        else if (left > cells)
        {
            while(--top >= 0 and sub_grid[# left, top]){}
            if (top < 0 or sub_grid[# left, top] != .5) ++top
            var old_bottom = bottom
            while(++bottom <= maxh and sub_grid[# left, bottom]){}
            if (bottom > maxh or sub_grid[# left, bottom] != .5) --bottom
            if (bottom < cells) bottom = old_bottom
        }
        else
            top = 0
        ds_grid_set_region(sub_grid,left,top,right,bottom,.5)
        draw_box_shadows(left,top,right,bottom)
    }//
    //check down area
    if sub_grid[# ii, cells + i]
    {
    debug_str = "down"
        var top = cells + i;
        var bottom = top;
        var left = ii, right = ii;
        while(--left >= 0 and sub_grid[# left, top]){}
        if (left < 0 or sub_grid[# left, top] != .5) ++left
        while(++right <= maxh and sub_grid[# right, top]){}
        if (right > maxh or sub_grid[# right, top] != .5) --right
        if (right < cells)
        {
            while(++bottom <= maxh and sub_grid[# right, bottom]){}
            if (bottom > maxh or sub_grid[# right, bottom] != .5) --bottom
            var old_top = top
            while(--top >= 0 and sub_grid[# right, top]){}
            if (top < 0 or sub_grid[# right, top] != .5) ++top
            if (top > cells) top = old_top
        }
        else if (left > cells)
        {
            while(++bottom <= maxh and sub_grid[# left, bottom]){}
            if (bottom > maxh or sub_grid[# left, bottom] != .5) --bottom
            var old_top = top
            while(--top >= 0 and sub_grid[# left, top]){}
            if (top < 0 or sub_grid[# left, top] != .5) ++top
            if (top > cells) top = old_top
        }
        else
            bottom = maxh
        ds_grid_set_region(sub_grid,left,top,right,bottom,.5)
        draw_box_shadows(left,top,right,bottom)
    }//
    //check left area
    if sub_grid[# cells - i, ii]
    {
        debug_str = "left"
        var right = cells - i;
        var left = right;
        var top = ii, bottom = ii;
        while(--top >= 0 and sub_grid[# right, top] > 0){}
        if (top < 0 or sub_grid[# right, top] != .5) ++top
        while(++bottom <= maxh and sub_grid[# right, bottom] > 0){}
        if (bottom > maxh or sub_grid[# right, bottom] != .5) --bottom
        if (top > cells)
        {
            while(--left >= 0 and sub_grid[# left, top]){}
            if (left < 0 or sub_grid[# left, top] != .5) ++left
            var old_right = right
            while(++right <= maxh and sub_grid[# right, top]){}
            if (right > maxh or sub_grid[# right, top] != .5) --right
            if (right < cells) right = old_right
        }
        else if (bottom < cells)
        {
            while(--left >= 0 and sub_grid[# left, bottom]){}
            if (left < 0 or sub_grid[# left, bottom] != .5) ++left
            var old_right = right
            while(++right <= maxh and sub_grid[# right, bottom]){}
            if (right > maxh or sub_grid[# right, bottom] != .5) --right
            if (right < cells) right = old_right
        }
        else
            left = 0        
        ds_grid_set_region(sub_grid,left,top,right,bottom,.5)
        draw_box_shadows(left,top,right,bottom)
    }//
    //check right area
    if sub_grid[# cells + i, ii]
    {
        debug_str = "right"
        var left = cells + i;
        var right = left
        var top = ii, bottom = ii;
        while(--top >= 0 and sub_grid[# left, top] > 0){}
        if (top < 0 or sub_grid[# left, top] != .5) ++top
        while(++bottom <= maxh and sub_grid[# left, bottom] > 0){}
        if (bottom > maxh or sub_grid[# left, bottom] != .5) --bottom
        if (top > cells)
        {
            while(++right <= maxh and sub_grid[# right, top]){}
            if (right > maxh or sub_grid[# right, top] != .5) --right
            var old_left = left
            while(--left >= 0 and sub_grid[# left, top]){}
            if (left < 0 or sub_grid[# left, top] != .5) ++left
            if (left > cells) left = old_left
        }
        else if (bottom < cells)
        {
            while(++right <= maxh and sub_grid[# right, bottom]){}
            if (right > maxh or sub_grid[# right, bottom] != .5) --right
            var old_left = left
            while(--left >= 0 and sub_grid[# left, bottom]){}
            if (left < 0 or sub_grid[# left, bottom] != .5) ++left
            if (left > cells) left = old_left
        }
        else
            right = maxh  
        ds_grid_set_region(sub_grid,left,top,right,bottom,.5)
        draw_box_shadows(left,top,right,bottom)
    }
}//*/

/*
var top = 0
var bottom = 0
var right = 0
var left = 0
section =""
for(var i = 0;i < cells - 1;i++)
{
    for(var ii = 0;ii < cells - 1;ii++)
    { 
        //up - left
        if sub_grid[# cells - i,cells - ii - 1] = 1
        {
            sub_grid[# cells - i,cells - ii - 1] = .5
            top = cells - ii - 1
            bottom = top
            left = cells - i
            right = left
            //left
            while(left - 1 > 0 and sub_grid[# left - 1,top] > 0)  
                sub_grid[# --left,top] *= .5
            //right
            while(right + 1< cells * 2 and sub_grid[# right + 1,top] > 0)
                sub_grid[# ++right,top] = .5
            //clear cells behind wall
            if cells > left and cells < right
            {
                ds_grid_set_region(sub_grid,left,0,right,top,.5)
            }
            //top
            else if cells >= right
            {
                 while(top - 1 > 0 and sub_grid[# right,top - 1] > 0)
                    sub_grid[# right,--top] = .5   
            }
            else if cells <= left
            {
                while(top - 1 > 0 and sub_grid[# left,top - 1] > 0)
                    sub_grid[# left,--top] = .5   
            }
            
            section = "ul"
            draw_box_shadows(left,top,right,bottom)
        }
        //up - right
        if sub_grid[# cells + i,cells - ii - 1] = 1
        {
            sub_grid[# cells + i,cells - ii - 1] = .5
            top = cells - ii - 1
            bottom = top
            left = cells + i
            right = left
            //left
            while(left - 1 > 0 and sub_grid[# left - 1,top] > 0)
                sub_grid[# --left,top] = .5
            //right
            while(right + 1< cells * 2 and sub_grid[# right + 1,top] > 0)
                sub_grid[# ++right,top] = .5
            if cells > left and cells < right
            {
                ds_grid_set_region(sub_grid,left,0,right,top,.5)
                //while(bottom + 1 < cells * 2 and sub_grid[# left, bottom + 1] > 0)
                //    sub_grid[# left, ++bottom] = .5
            }
            //top
            else if cells <= left
            {
                 while(top - 1 > 0 and sub_grid[# left,top - 1] > 0)
                    sub_grid[# left,--top] = .5  
                    
            }
            else if cells >= right
            {
                 while(top - 1 > 0 and sub_grid[# right,top - 1] > 0)
                    sub_grid[# right,--top] = .5   
            }
            if left = right 
            {
                while(bottom + 1 < cells * 2 and sub_grid[# left, bottom + 1] > 0)
                    sub_grid[# left, ++bottom] = .5
            }
            section = "ur"
            draw_box_shadows(left,top,right,bottom)
        }
        //bottom - left
        if sub_grid[# cells - i,cells + ii + 1] = 1
        {
            sub_grid[# cells - i,cells + ii + 1] = .5
            top = cells + ii + 1
            bottom = top
            left = cells - i
            right = left
            //left
            while(left - 1 > 0 and sub_grid[# left - 1,top] > 0)
                sub_grid[# --left,top] = .5
            //right
            while(right + 1< cells * 2 and sub_grid[# right + 1,top] > 0)
                sub_grid[# ++right,top] = .5
            if cells > left and cells < right
            {
                ds_grid_set_region(sub_grid,left,top,right,ds_grid_height(sub_grid) - 1,.5)
            }
            //top
            else if cells >= right
            {
                //show_debug_message(sub_grid[# right,bottom + 1])
                 while(bottom + 1< cells * 2 and sub_grid[# right,bottom + 1] > 0)
                    sub_grid[# right,++bottom] = .5    
            }
            else if cells <= left 
            {
                while(bottom + 1< cells * 2 and sub_grid[# left,bottom + 1] > 0)
                    sub_grid[# left,++bottom] = .5   
            }
            if left = right
            {
                while(top - 1 >= 0 and sub_grid[# left, top - 1] > 0)
                    sub_grid[# left, --top] = .5
            }
            section = "bl"
            draw_box_shadows(left,top,right,bottom)
        }//
        //bottom - right
        if sub_grid[# cells + i,cells + ii + 1] = 1
        {
            sub_grid[# cells + i,cells + ii + 1] = .5
            top = cells + ii + 1
            bottom = top
            left = cells + i
            right = left
            //left
            while(left - 1 > 0 and sub_grid[# left - 1,top] > 0)
                sub_grid[# --left,top] = .5
            //right
            while(right + 1< cells * 2 and sub_grid[# right + 1,top] > 0)
                sub_grid[# ++right,top] = .5
            if cells > left and cells < right
            {
                ds_grid_set_region(sub_grid,left,top,right,ds_grid_height(sub_grid) - 1,.5)
            }
            //top
            else if cells <= left
            {
                 while(bottom + 1< cells * 2 and sub_grid[# left,bottom + 1] > 0)
                    sub_grid[# left,++bottom] = .5   
            }
            else if cells >= right
            {
                while(bottom + 1< cells * 2 and sub_grid[# right,bottom + 1] > 0)
                    sub_grid[# right,++bottom] = .5   
            }
            if left = right
            {
                while(top - 1 >= 0 and sub_grid[# left, top - 1] > 0)
                    sub_grid[# left, --top] = .5
            }
            section = "br"
            draw_box_shadows(left,top,right,bottom)
            
        }
        //left - top
        if sub_grid[# cells - ii - 1,cells - i] = 1
        {
            sub_grid[# cells - ii - 1,cells - i] = .5
            top = cells - i
            bottom = top
            left = cells - ii - 1
            right = left
            //left
            while(top - 1 > 0 and sub_grid[# left, top - 1] > 0)
                sub_grid[# left, --top] = .5
            while(bottom + 1< cells * 2 and sub_grid[# left, bottom + 1] > 0)
                sub_grid[# left, ++bottom] = .5
            //clear grid behind wall
            if cells > floor(top) and cells < ceil(bottom)
            {
                ds_grid_set_region(sub_grid,0,top,left - 1,bottom,.5)
            }
            //top
            else if cells >= bottom
            {
                 while(left - 1 > 0 and sub_grid[# left - 1,bottom] > 0)
                    sub_grid[# --left,bottom] = .5   
            }
            else if cells <= top
            {
                while(left - 1 > 0 and sub_grid[# left - 1,top] > 0)
                    sub_grid[# --left,top] = .5   
            }
            section = "lt"
            draw_box_shadows(left,top,right,bottom)
        }
        //left - bottom
        if sub_grid[# cells - ii - 1,cells + i] = 1
        {
            sub_grid[# cells - ii - 1,cells + i] = .5
            top = cells + i
            bottom = top
            left = cells - ii - 1
            right = left
            while(top - 1 > 0 and sub_grid[# left, top - 1] > 0)
                sub_grid[# left, --top] = .5
            while(bottom + 1< cells * 2 and sub_grid[# left, bottom + 1] > 0)
                sub_grid[# left, ++bottom] = .5
            if cells > top and cells < bottom
            {
                ds_grid_set_region(sub_grid,0,top,left - 1,bottom,.5)
            }
            else if cells <= top
            {
                 while(left - 1 > 0 and sub_grid[# left - 1,top] > 0)
                    sub_grid[# --left,top] = .5   
            }
            else if cells >= bottom
            {
                 while(left - 1 > 0 and sub_grid[# left - 1,bottom] > 0)
                    sub_grid[# --left,bottom] = .5   
            }
            section = "lb"
            draw_box_shadows(left,top,right,bottom)
        }
        //right - top
        if sub_grid[# cells + ii + 1,cells - i] = 1
        {
            sub_grid[# cells + ii + 1,cells - i] = .5
            top = cells - i
            bottom = top
            left = cells + ii + 1
            right = left
            //left
            while(top - 1 > 0 and sub_grid[# left, top - 1] > 0)
                sub_grid[# left, --top] = .5
            //right
            while(bottom + 1< cells * 2 and sub_grid[# left, bottom + 1] > 0)
                sub_grid[# left, ++bottom] = .5
            //clear grid behind wall
            if cells > top and cells < bottom
            {
                ds_grid_set_region(sub_grid,left,top,ds_grid_width(sub_grid) - 1,bottom,.5)
                //while(bottom + 1 < cells * 2 and sub_grid[# left, bottom + 1] > 0)
                //    sub_grid[# left, ++bottom] = .5
            }
            else if cells >= bottom
            {
                 while(right + 1< cells * 2 and sub_grid[# right + 1,bottom] > 0)
                    sub_grid[# ++right,bottom] = .5   
            }
            else if cells <= top
            {
                 while(right + 1< cells * 2 and sub_grid[# right + 1,top] > 0)
                    sub_grid[# ++right,top] = .5   
            }
            section = "rt"
            draw_box_shadows(left,top,right,bottom)
        }
        
        //right - bottom
        if sub_grid[# cells + ii + 1,cells + i] = 1
        {
            sub_grid[# cells + ii + 1,cells + i] = .5
            top = cells + i
            bottom = top
            left = cells + ii + 1
            right = left
            while(top - 1 > 0 and sub_grid[# left, top - 1] > 0)
                sub_grid[# left, --top] = .5
            while(bottom + 1< cells * 2 and sub_grid[# left, bottom + 1] > 0)
                sub_grid[# left, ++bottom] = .5
            if cells > top and cells < bottom
            {
                ds_grid_set_region(sub_grid,left,top,ds_grid_width(sub_grid) - 1,bottom,.5)
            }
            else if cells <= top
            {
                 while(right + 1< cells * 2 and sub_grid[# right + 1,top] > 0)
                    sub_grid[# ++right,top] = .5   
            }
            else if cells >= bottom
            {
                 while(right + 1< cells * 2 and sub_grid[# right + 1,bottom] > 0)
                    sub_grid[# ++right,bottom] = .5   
            }
            section = "rb"
            draw_box_shadows(left,top,right,bottom)
        }//
    }
}//*/
ds_grid_destroy(sub_grid)
surface_reset_target()
if surface_exists(global.darkness)
{
    surface_set_target(global.darkness)
    draw_surface(lights,x - e_view_range * CELL_SIZE - view_xview,y - e_view_range * CELL_SIZE - view_yview)
    surface_reset_target()
}
draw_set_blend_mode(bm_normal)
