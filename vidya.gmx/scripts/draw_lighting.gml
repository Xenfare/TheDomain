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
                sub_grid[# --left,top] = .5
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
        }//*/
    }
}
ds_grid_destroy(sub_grid)
surface_reset_target()
if surface_exists(global.darkness)
{
    surface_set_target(global.darkness)
    draw_surface(lights,x - e_view_range * CELL_SIZE - view_xview,y - e_view_range * CELL_SIZE - view_yview)
    surface_reset_target()
}
draw_set_blend_mode(bm_normal)
