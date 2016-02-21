        var wall_lining_size = 24 
        var e_view_range = ceil(view_range/global.cell_size) * global.cell_size
        var true_bbox_left  = floor(x-e_view_range) + (argument0-2) * global.cell_size - (x-e_view_range)%global.cell_size
        var true_bbox_right = floor(x-e_view_range) + (argument2-1) * global.cell_size - (x-e_view_range)%global.cell_size
        var true_bbox_top = floor(y-e_view_range) + (argument1-2) * global.cell_size - (y-e_view_range)%global.cell_size
        var true_bbox_bottom = floor(y-e_view_range) + (argument3-1) * global.cell_size - (y-e_view_range)%global.cell_size
        /*if true_bbox_left < x - e_view_range
            true_bbox_left = x - e_view_range
        if true_bbox_right > x + e_view_range
            true_bbox_right = x + e_view_range
        if true_bbox_top < y - e_view_range
            true_bbox_top = y - e_view_range
        if true_bbox_bottom > y + e_view_range
            true_bbox_bottom = y + e_view_range*/
        var pos = 0;     
        var true_x = (true_bbox_right + true_bbox_left)/2
        var true_y = (true_bbox_top + true_bbox_bottom)/2
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
        var dir = point_direction(x,y,true_x,true_y)
        if x >= true_bbox_left and x <= true_bbox_right
        {
            dir = point_direction(x,y,true_x,true_y)
            if y > true_bbox_top
            {
                side_x1 = true_bbox_right //+ 1
                side_x2 =true_bbox_left //- 1
                side_y1 =true_bbox_bottom //+ 1
                side_y2 =true_bbox_bottom //+ 1
                dir1 = point_direction(x,y,side_x1,side_y1)
                dir2 = point_direction(x,y,side_x2,side_y2)
                if dtan((dir1)) = 0 or dtan((dir2)) = 0
                    return 0;
                side_ox1 = wall_lining_size/dtan((dir1))
                side_ox2 = wall_lining_size/dtan((dir2))
                side_oy1 = -wall_lining_size
                side_oy2 = side_oy1
                side_oyy1 = side_oy1
                side_oyy2 = side_oy1
                pos = 1
            }
            else
            {
                side_x1 =true_bbox_left
                side_x2 =true_bbox_right// - 1
                side_y1 =true_bbox_top //- 1
                side_y2 =true_bbox_top //- 1
                dir1 = point_direction(x,y,side_x1,side_y1)
                dir2 = point_direction(x,y,side_x2,side_y2)
                if dtan((dir1)) = 0 or dtan(dir2) = 0
                    return 0;
                side_ox1 = -wall_lining_size/dtan(dir1)
                side_ox2 = -wall_lining_size/dtan(ir2)
                side_oy1 = wall_lining_size
                side_oy2 = side_oy1
                side_oyy1 = side_oy1
                side_oyy2 = side_oy1
                pos = 2
            }
        }
        else if y >=true_bbox_top and y <= true_bbox_bottom
        {
            dir = point_direction(x,y,true_x,true_y)
            if x > true_bbox_left
            {
                side_x1 =true_bbox_right //+ 1
                side_x2 =true_bbox_right //+ 1
                side_y1 =true_bbox_bottom //+ 1
                side_y2 =true_bbox_top// - 1
                dir1 = point_direction(x,y,side_x1,side_y1)
                dir2 = point_direction(x,y,side_x2,side_y2)
                if dtan(dir1+90) = 0 or dtan(dir2+90) = 0
                    return 0;
                side_oy1 = -wall_lining_size/dtan(dir1+90)
                side_oy2 = -wall_lining_size/dtan(dir2+90)
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
                dir1 = point_direction(x,y,side_x1,side_y1)
                dir2 = point_direction(x,y,side_x2,side_y2)
                if dtan((dir1+90)) = 0 or dtan((dir2+90)) = 0
                    return 0;
                side_oy1 = wall_lining_size/dtan((dir1+90))
                side_oy2 = wall_lining_size/dtan((dir2+90))
                side_ox1 = wall_lining_size
                side_ox2 = side_ox1
                side_oxx1 = side_ox1
                side_oxx2 = side_ox1
                pos = 4
            }
        }
        else if dir >= 90 and dir < 180
        {
            side_x1 = true_bbox_right //+ 1
            side_x2 = true_bbox_left //- 1
            side_y1 = true_bbox_top //- 1
            side_y2 = true_bbox_bottom //+ 1
            dir1 = point_direction(x,y,side_x1,side_y1)
            dir2 = point_direction(x,y,side_x2,side_y2)
            side_oxx1 = -wall_lining_size
            //side_oyy1 = wall_lining_size
            side_oyy2 = -wall_lining_size
            side_ocx = side_x1 - wall_lining_size
            side_ocy = side_y2 - wall_lining_size
            pos = 5
        }
        else if  dir >= 180 and dir < 270
        {
            side_x1 = true_bbox_left //- 1
            side_x2 = true_bbox_right //+ 1
            side_y1 = true_bbox_top //- 1
            side_y2 = true_bbox_bottom// + 1
            dir1 = point_direction(x,y,side_x1,side_y1)
            dir2 = point_direction(x,y,side_x2,side_y2)
            side_oyy1 = wall_lining_size
            //side_oxx1 = wall_lining_size
            side_oxx2 = wall_lining_size
            side_ocx = side_x2 - wall_lining_size
            side_ocy = side_y1 + wall_lining_size
            pos = 6
        }
        else if dir >= 270 or dir <= 0
        {
            side_x1 = true_bbox_left //- 1
            side_x2 = true_bbox_right //+ 1
            side_y1 = true_bbox_bottom //- 1
            side_y2 = true_bbox_top// + 1
            dir1 = point_direction(x,y,side_x1,side_y1)
            dir2 = point_direction(x,y,side_x2,side_y2)
            side_oxx1 = wall_lining_size
            //side_oyy1 = -wall_lining_size
            side_oyy2 = wall_lining_size
            side_ocx = side_x1 + wall_lining_size
            side_ocy = side_y2 + wall_lining_size
            pos = 7
        }
        else
        {
            side_x1 = true_bbox_left //- 1
            side_x2 = true_bbox_right //+ 1
            side_y1 = true_bbox_top //- 1
            side_y2 = true_bbox_bottom //+ 1
            dir1 = point_direction(x,y,side_x1,side_y1)
            dir2 = point_direction(x,y,side_x2,side_y2)
            side_oxx1 = wall_lining_size
            //side_oyy1 = wall_lining_size
            side_oyy2 = -wall_lining_size
            side_ocx = side_x1 + wall_lining_size
            side_ocy = side_y2 - wall_lining_size
            pos = 8
        }
        
        var x_offset = floor(x) - e_view_range
        var y_offset = floor(y) - e_view_range
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
        draw_vertex(side_x1 - x_offset+lengthdir_x(999999,dir1),side_y1 - y_offset+lengthdir_y(999999,dir1))
        draw_vertex(side_x1 - x_offset + side_ox1,side_y1 - y_offset + side_oy1)
        if pos > 4
        {
            draw_vertex(side_x1 - x_offset + side_oxx1,side_y1 - y_offset + side_oyy1)
            draw_vertex(side_ocx - x_offset,side_ocy - y_offset)
            draw_vertex(side_x2 - x_offset - side_oxx2,side_y2 - y_offset + side_oyy2)
        } 
        draw_vertex(side_x2 - x_offset + side_ox2,side_y2 - y_offset + side_oy2)
        draw_vertex(side_x2 - x_offset+lengthdir_x(999999,dir2),side_y2 - y_offset+lengthdir_y(999999,dir2))
        //draw_vertex(true_x - x_offset+lengthdir_x(999999,dir),true_y - y_offset+lengthdir_y(999999,dir))
        
        draw_primitive_end()
