/*///draw_lighting
if !surface_exists(lights)
    lights = surface_create(view_range * 2, view_range * 2)
surface_set_target(lights)
draw_clear_alpha(c_white,0)
draw_set_blend_mode(bm_add)
draw_set_color(c_white)
draw_circle(view_range,view_range,view_range,0)
draw_set_color(c_black)
draw_set_blend_mode(bm_subtract)
var precal = ds_list_create()
with(wall)
{
    view_range = other.view_range
    if distance_to_object(other) < view_range and ds_list_find_index(precal,id) = -1
    {
        var wall_lining_size = 4
        var true_bbox_left  = bbox_left
        var true_bbox_right = bbox_right
        var true_bbox_top = bbox_top
        var true_bbox_bottom = bbox_bottom    
        var pos = 0;     
        var true_x = x + sprite_width/2
        var true_y = y + sprite_height/2
        var side_x1 = x
        var side_x2 = x
        var side_y1 = y
        var side_y2 = y
        var side_ox1 = 0
        var side_ox2 = 0
        var side_oy1 = 0
        var side_oy2 = 0
        var side_oxx1 = 0
        var side_oxx2 = 0
        var side_oyy1 = 0
        var side_oyy2 = 0
        var side_ocx = 0
        var side_ocy = 0
        var dir1 = 0
        var dir2 = 0
        var dir = point_direction(other.x,other.y,true_x,true_y)
        if other.x >= true_bbox_left - 1 and other.x < true_bbox_right + 1
        {
            true_bbox_left = group_bbox(2,precal)
            true_bbox_right = group_bbox(0,precal)
            dir = point_direction(other.x,other.y,true_x,true_y)
            if other.y > y
            {
                side_x1 = true_bbox_right + 1
                side_x2 =true_bbox_left //- 1
                side_y1 =true_bbox_bottom //+ 1
                side_y2 =true_bbox_bottom //+ 1
                dir1 = point_direction(other.x,other.y,side_x1,side_y1)
                dir2 = point_direction(other.x,other.y,side_x2,side_y2)
                side_ox1 = wall_lining_size/tan(degtorad(dir1))
                side_ox2 = wall_lining_size/tan(degtorad(dir2))
                side_oy1 = -wall_lining_size
                side_oy2 = side_oy1
                side_oyy1 = side_oy1
                side_oyy2 = side_oy1
                pos = 1
            }
            else
            {
                side_x1 = true_bbox_right
                side_x2 =true_bbox_left// - 1
                side_y1 =true_bbox_top //- 1
                side_y2 =true_bbox_top //- 1
                dir1 = point_direction(other.x,other.y,side_x1,side_y1)
                dir2 = point_direction(other.x,other.y,side_x2,side_y2)
                side_ox1 = -wall_lining_size/tan(degtorad(dir1))
                side_ox2 = -wall_lining_size/tan(degtorad(dir2))
                side_oy1 = wall_lining_size
                side_oy2 = side_oy1
                side_oyy1 = side_oy1
                side_oyy2 = side_oy1
                pos = 2
            }
        }
        else if other.y >=true_bbox_top - 1 and other.y < true_bbox_bottom + 1
        {
            true_bbox_top = group_bbox(1,precal)
            true_bbox_bottom = group_bbox(3,precal)
            dir = point_direction(other.x,other.y,true_x,true_y)
            if other.x > x
            {
                side_x1 =true_bbox_right //+ 1
                side_x2 =true_bbox_right //+ 1
                side_y1 =true_bbox_bottom + 1
                side_y2 =true_bbox_top// - 1
                dir1 = point_direction(other.x,other.y,side_x1,side_y1)
                dir2 = point_direction(other.x,other.y,side_x2,side_y2)
                side_oy1 = -wall_lining_size/tan(degtorad(dir1+90))
                side_oy2 = -wall_lining_size/tan(degtorad(dir2+90))
                side_ox1 = -wall_lining_size
                side_ox2 = side_ox1
                side_oxx1 = side_ox1
                side_oxx2 = side_ox1
                pos = 3
            }
            else
            {
                side_x1 =true_bbox_left //- 1
                side_x2 =true_bbox_left //- 1
                side_y1 =true_bbox_bottom// + 1
                side_y2 =true_bbox_top// - 1
                dir1 = point_direction(other.x,other.y,side_x1,side_y1)
                dir2 = point_direction(other.x,other.y,side_x2,side_y2)
                side_oy1 = wall_lining_size/tan(degtorad(dir1+90))
                side_oy2 = wall_lining_size/tan(degtorad(dir2+90))
                side_ox1 = wall_lining_size
                side_ox2 = side_ox1
                side_oxx1 = side_ox1
                side_oxx2 = side_ox1
                pos = 4
            }
        }
        else if dir >= 90 and dir < 180
        {
            true_bbox_right = group_bbox(0,precal)
            true_bbox_bottom = group_bbox(3,precal)
            side_x1 = true_bbox_right + 1
            side_x2 = true_bbox_left //- 1
            side_y1 = true_bbox_top //- 1
            side_y2 = true_bbox_bottom + 1
            dir1 = point_direction(other.x,other.y,side_x1,side_y1)
            dir2 = point_direction(other.x,other.y,side_x2,side_y2)
            side_oxx1 = -wall_lining_size
            side_oyy2 = -wall_lining_size
            side_ocx = side_x1 - wall_lining_size
            side_ocy = side_y2 - wall_lining_size
            pos = 5
        }
        else if  dir >= 180 and dir < 270
        {
            true_bbox_left = group_bbox(2,precal)
            true_bbox_bottom = group_bbox(3,precal)
            side_x1 = true_bbox_left //- 1
            side_x2 = true_bbox_right + 1
            side_y1 = true_bbox_top - 1
            side_y2 = true_bbox_bottom + 1
            dir1 = point_direction(other.x,other.y,side_x1,side_y1)
            dir2 = point_direction(other.x,other.y,side_x2,side_y2)
            side_oyy1 = wall_lining_size
            side_oxx2 = -wall_lining_size
            side_ocx = side_x2 - wall_lining_size
            side_ocy = side_y1 + wall_lining_size
            pos = 6
        }
        else if dir >= 270 or dir <= 0
        {
            true_bbox_top = group_bbox(1,precal)
            true_bbox_left = group_bbox(2,precal)
            side_x1 = true_bbox_left - 1
            side_x2 = true_bbox_right + 1
            side_y1 = true_bbox_bottom //- 1
            side_y2 = true_bbox_top// + 1
            dir1 = point_direction(other.x,other.y,side_x1,side_y1)
            dir2 = point_direction(other.x,other.y,side_x2,side_y2)
            side_oxx1 = wall_lining_size
            side_oyy2 = wall_lining_size
            side_ocx = side_x1 + wall_lining_size
            side_ocy = side_y2 + wall_lining_size
            pos = 7
        }
        else
        {
            true_bbox_top = group_bbox(1,precal)
            true_bbox_right = group_bbox(0,precal)
            side_x1 = true_bbox_left //- 1
            side_x2 = true_bbox_right //+ 1
            side_y1 = true_bbox_top //- 1
            side_y2 = true_bbox_bottom + 1
            dir1 = point_direction(other.x,other.y,side_x1,side_y1)
            dir2 = point_direction(other.x,other.y,side_x2,side_y2)
            side_oxx1 = wall_lining_size
            side_oyy2 = -wall_lining_size
            side_ocx = side_x1 + wall_lining_size
            side_ocy = side_y2 - wall_lining_size
            pos = 8
        }
        
        var x_offset = other.x - view_range
        var y_offset = other.y - view_range
        if pos > 0 and pos < 5
        {
            draw_primitive_begin(pr_trianglelist)
            draw_vertex(side_x2 - x_offset,side_y2 - y_offset)
            draw_vertex(side_x2 - x_offset + side_ox2,side_y2 - y_offset + side_oy2)
            draw_vertex(side_x2 - x_offset + side_oxx2,side_y2 - y_offset + side_oyy2)
            draw_vertex(side_x1 - x_offset,side_y1 - y_offset)
            draw_vertex(side_x1 - x_offset + side_ox1,side_y1 - y_offset + side_oy1)
            draw_vertex(side_x1 - x_offset + side_oxx1,side_y1 - y_offset + side_oyy1)
            draw_primitive_end()
        }
        draw_primitive_begin(pr_trianglefan)
        
        if pos > 4
        {
            draw_vertex(side_x1 - x_offset + side_oxx1,side_y1 - y_offset + side_oyy1)
            draw_vertex(side_ocx - x_offset,side_ocy - y_offset)
            draw_vertex(side_x2 - x_offset + side_oxx2,side_y2 - y_offset + side_oyy2)
        } 
        draw_vertex(side_x2 - x_offset + side_ox2,side_y2 - y_offset + side_oy2)
        draw_vertex(side_x2 - x_offset+lengthdir_x(view_range * 2,dir2),side_y2 - y_offset+lengthdir_y(view_range * 2,dir2))
        draw_vertex(true_x - x_offset+lengthdir_x(view_range * 2,dir),true_y - y_offset+lengthdir_y(view_range * 2,dir))
        draw_vertex(side_x1 - x_offset+lengthdir_x(view_range * 2,dir1),side_y1 - y_offset+lengthdir_y(view_range * 2,dir1))
        draw_vertex(side_x1 - x_offset + side_ox1,side_y1 - y_offset + side_oy1)
        draw_primitive_end()
    }
}
surface_reset_target()
if surface_exists(global.darkness)
{
    surface_set_target(global.darkness)
    draw_surface(lights,x - view_range - view_xview,y - view_range - view_yview)
    surface_reset_target()
}
draw_set_blend_mode(bm_normal)
*/
///draw_lighting
if !surface_exists(lights)
    lights = surface_create(view_range * 2, view_range * 2)
surface_set_target(lights)
draw_clear_alpha(c_white,0)
draw_set_blend_mode(bm_add)
draw_set_color(c_white)
draw_circle(view_range,view_range,view_range,0)
draw_set_color(c_black)
draw_set_blend_mode(bm_subtract)
with(wall)
{
    view_range = other.view_range
    if distance_to_object(other) < view_range
    {
        var true_bbox_left  = bbox_left
        var true_bbox_right = bbox_right
        var true_bbox_top = bbox_top
        var true_bbox_bottom = bbox_bottom
        var pos = 0;     
        var true_x = x + sprite_width/2
        var true_y = y + sprite_height/2
        var side_x1 = x
        var side_x2 = x
        var side_y1 = y
        var side_y2 = y
        draw_primitive_begin(pr_trianglefan)
        var dir = point_direction(other.x,other.y,true_x,true_y)
        if other.x >= true_bbox_left - 1 and other.x <= true_bbox_right + 1
        {
            true_y = (true_bbox_top - 1 + true_bbox_bottom + 1) / 2
            true_x = (true_bbox_right + 1 + true_bbox_left - 1) / 2
            dir = point_direction(other.x,other.y,true_x,true_y)
            if other.y > y
            {
                side_x1 = true_bbox_right + 1
                side_x2 =true_bbox_left - 1
                side_y1 =true_bbox_bottom //+ 1
                side_y2 =true_bbox_bottom //+ 1
                pos = 1
            }
            else
            {
                side_x1 =true_bbox_right + 1
                side_x2 =true_bbox_left - 1
                side_y1 =true_bbox_top //- 1
                side_y2 =true_bbox_top //- 1
                pos = 2
            }
        }
        else if other.y >=true_bbox_top - 1 and other.y <=true_bbox_bottom + 1
        {
            true_y = (true_bbox_top - 1 + true_bbox_bottom + 1) / 2
            true_x = (true_bbox_right + 1 + true_bbox_left - 1) / 2
            dir = point_direction(other.x,other.y,true_x,true_y)
if other.x > x
            {
                side_x1 =true_bbox_right //+ 1
                side_x2 =true_bbox_right //+ 1
                side_y1 =true_bbox_bottom + 1
                side_y2 =true_bbox_top - 1
                pos = 3
            }
            else
            {
                side_x1 =true_bbox_left //- 1
                side_x2 =true_bbox_left //- 1
                side_y1 =true_bbox_bottom + 1
                side_y2 =true_bbox_top - 1
                pos = 4
            }
        }
        else if dir >= 90 and dir < 180
        {
            side_x1 = bbox_right + 1
            side_x2 = bbox_left - 1
            side_y1 = bbox_top //- 1
            side_y2 = bbox_bottom + 1
        }
        else if  dir >= 180 and dir < 270
        {
            side_x1 = bbox_left - 1
            side_x2 = bbox_right + 1
            side_y1 = bbox_top - 1
            side_y2 = bbox_bottom + 1
        }
        else if dir >= 270 or dir <= 0
        {
            side_x1 = bbox_left - 1
            side_x2 = bbox_right + 1
            side_y1 = bbox_bottom + 1
            side_y2 = bbox_top - 1
        }
        else
        {
            side_x1 = bbox_left - 1
            side_x2 = bbox_right + 1
            side_y1 = bbox_top
            side_y2 = bbox_bottom + 1
        }
        var x_offset = other.x - view_range
        var y_offset = other.y - view_range
        draw_vertex(side_x1 - x_offset,side_y1 - y_offset)
        draw_vertex(side_x2 - x_offset,side_y2 - y_offset)
        var dir1 = point_direction(other.x,other.y,side_x1,side_y1)
        var dir2 = point_direction(other.x,other.y,side_x2,side_y2)
        draw_vertex(side_x2 - x_offset+lengthdir_x(view_range * 2,dir2),side_y2 - y_offset+lengthdir_y(view_range * 2,dir2))
        draw_vertex(true_x - x_offset+lengthdir_x(view_range * 2,dir),true_y - y_offset+lengthdir_y(view_range * 2,dir))
        draw_vertex(side_x1 - x_offset+lengthdir_x(view_range * 2,dir1),side_y1 - y_offset+lengthdir_y
 (view_range * 2,dir1)) draw_primitive_end()
    }
}
surface_reset_target()
if surface_exists(global.darkness)
{
    surface_set_target(global.darkness)
    draw_surface(lights,x - view_range - view_xview,y - view_range - view_yview)
    surface_reset_target()
}
draw_set_blend_mode(bm_normal)
