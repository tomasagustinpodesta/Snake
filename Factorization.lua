
Class = require 'class'
Factorization = Class{}

function Factorization:init()
    --nothing
end

--collision detection
--needs two objects, each of them with an x, y, width and height
--returns true if there is a collision and false if its not
function Factorization:collides(objAx, objAy, objBx, objBy)
    if objAx > objBx + 10 or objBx > objAx + 10 then
        return false
    end
    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if objAy > objBy + 10 or objBy > objAy + 10 then
        return false
    end 
    return true
end

--checks the direction to block the movement in case its the opposite one
--true: allowed
--false: not allowed
function Factorization:checkDirection(oldDir, newDir)
    if oldDir == 'right' and newDir == 'left' then 
        return false
    elseif oldDir == 'left' and newDir == 'right' then 
        return false
    elseif oldDir == 'up' and newDir == 'down' then 
        return false
    elseif oldDir == 'down' and newDir == 'up' then 
        return false
    end
    return true
end