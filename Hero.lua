

Hero = Class{}


function Hero:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = -50
    self.dx = 0
    self.state = 'up'
end

function Hero:switchStatus()
    if (self.state == 'up') then
        self.state = 'down'
        self.dy = 10
    elseif self.state == 'down' then
        self.state = 'up'
        self.dy = -50
    end
end

function Hero:update(dt)
    if self.state == 'up' then
        self.y = self.y + self.dy * dt
        self.dy = self.dy+-3
    else
        self.y = self.y + self.dy * dt
        self.dy = self.dy+3
    end

    if (self.y <= VIRTUAL_HEIGHT*0.25 and self.state == 'up')
     or (self.y >= VIRTUAL_HEIGHT - self.height and self.state == 'down')
      then 
        self:switchStatus()
    end

    self.x = self.x + self.dx * dt
end

function Hero:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end