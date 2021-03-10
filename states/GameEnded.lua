GameEnded = Class{}




function GameEnded:render()
    love.graphics.setFont(largeFont)
    love.graphics.printf('Game Over!', 0, VIRTUAL_HEIGHT/2 -25, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)
    love.graphics.printf('Press any button to start againe', 0, VIRTUAL_HEIGHT/2+25, VIRTUAL_WIDTH, 'center')
end