if spd = 0 return 0
if collision_line(x,y,x+lengthdir_x(spd, direction),y+lengthdir_y(spd, direction),worldwall,false,true) || place_meeting(x+lengthdir_x(spd, direction), y+lengthdir_y(spd, direction), worldwall)
{
    var s = abs(spd)
    var dir = direction;
    if spd < 0
    dir += 180
            var i = 0;
            var xmov = lengthdir_x(1,dir)
            var ymov = lengthdir_y(1,dir) 
            while(i < s)
            {
                if !place_meeting(x + xmov, y, worldwall) && !place_meeting(x + xmov, y, enemyparent)
                    x += xmov;
                else
                    x -= ceil(xmov);
                if !place_meeting(x - xmov, y + ymov, worldwall) && !place_meeting(x - xmov, y + ymov, enemyparent)
                    y += ymov;
                else
                    y -= ceil(ymov);
                i++;  
            }
            if place_meeting(x, y, worldwall)
            {
                x -= ceil(xmov);
                y -= ceil(ymov);
            }
}
else
{
    x += lengthdir_x(spd,direction)
    y += lengthdir_y(spd,direction)
}
