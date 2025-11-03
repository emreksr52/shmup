function _init()
cls(0)
ship_x = 64
ship_y = 64
mini = 99
shipspd_x = 0
shipspd_y = 0

bullx = 64
bully= 40
end

function _update()

    shipspd_x = 0
    shipspd_y = 0

    bully = bully - 2

    if btn(0) then
        shipspd_x = -2
    end

    if btn(1) then
        shipspd_x = 2
    end

    if btn(2) then
        shipspd_y = -2
    end

    if btn(3) then
        shipspd_y = 2
    end

     if btnp(5) then
        bully = ship_y - 5
        bullx = ship_x
        spr(002, ship_x, ship_y)
        sfx(0)
    end


    ship_x = ship_x + shipspd_x
    ship_y = ship_y + shipspd_y

    if ship_x>120 then
        ship_x = 120
    end

    if ship_x < 0 then
        ship_x = 0
    end

     if ship_y>120 then
        ship_y = 120
    end

    if ship_y < 0 then
        ship_y = 0
    end

   


end

function _draw()
    cls()
    draw_ship()
    spr(002, bullx, bully)
   
end

function draw_ship()
    spr(001, ship_x, ship_y)
    
end

function move_ship()
end

