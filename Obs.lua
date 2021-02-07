

Obs = Class{}


function Obs:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.active = true;
end

function Obs:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Obs:collides(hero)
    if self.x > hero.x + hero.width or hero.x > self.x + self.width then
        return false
    end
        
    if self.y+5 > hero.y + hero.height and self.y-5 < hero.y +hero.height then
        return true
    end 

    -- if self.y > hero.y + hero.height or hero.y > self.y + self.height then
    --     return false
    -- end 

    -- return true
end