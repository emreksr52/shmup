function _init()
cls(0)
ship_x = 64
ship_y = 64
mini = 99
shipspd_x = 0
shipspd_y = 0

bullx = 64
bully= -10
shipspr = 2
flamespr = 5
muzzle = 0
bulletspr = 16

score = 0
lives = 3
bombs = 3

end

function _update()

    shipspr = 2

    shipspd_x = 0
    shipspd_y = 0

    bully = bully - 2

    if btn(0) then
        shipspd_x = -2
        shipspr = 1
    end

    if btn(1) then
        shipspd_x = 2
        shipspr = 3
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
        muzzle = 5
        sfx(0)
        score = score + 100
        bombs = bombs - 1
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

    flamespr = flamespr +1

    if flamespr > 9 then
        flamespr = 5
    end
    if muzzle > 0  then
    muzzle = muzzle - 1
    end

    if bulletspr > 15  then
    bulletspr = bulletspr + 1
    end

    end

function _draw()
    cls()
    draw_ship(shipspr)
    draw_flame(flamespr)
    spr(bulletspr, bullx, bully)
    if bulletspr > 21 then
        bulletspr = 16
    end
    
    if muzzle > 0  then
        circfill(ship_x + 4, ship_y - 1,muzzle, 7)
    end
    print("score:" ..score, 40, 1, 12)
    

    for i = 1, 3 do
        if lives >=i then
        spr(13, i*9 - 8, 1)
        else
        spr(14, i*9 - 8, 1)   
        end
        
    end

    for i = 1, 3 do
        if bombs >=i then
        spr(29, i*9 + 100 - 8, 1)
        else
        spr(30, i*9 + 100 - 8, 1)   
        end
        
    end
  
    
   
end

function draw_ship(shipspr)
    spr(shipspr, ship_x, ship_y)
    
end

function draw_flame(flamespr)
    spr(flamespr, ship_x, ship_y + 8)
end

function animate_flame(flamespr)
    
    
end

function move_ship()
end

