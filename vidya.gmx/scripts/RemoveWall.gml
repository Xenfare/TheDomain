///RemoveWall(wallid)
if !instance_exists(argument0) 
    return 0;
global.wall_grid[# argument0.x div CELL_SIZE, argument0.y div CELL_SIZE] = 0;
instance_destroy(argument0)
return 1;
