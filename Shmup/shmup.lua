function _init()
cls(0)
mode = "Start"
blinkt = 0
real_time = 0
fps = 0
end

function _update()
    blinkt += 1
    if mode == "Start" then
        start_button()
    elseif mode == "Game" then
        update_game()
    elseif mode == "Over" then
        game_over()
    elseif mode == "Countdown" then
        return 0  
    end
end


function _draw()
    if mode == "Game" then
        draw_game()
    elseif mode == "Start" then
        draw_start()
    else
        
    end
    print_logs()

   
end

function print_logs()
    print("Mode= "..mode, 40, 10, 7)
    print("Real time= "..real_time, 65, 20, 7)
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

function starfield()
    for i=1,#stars do
        local s = stars[i]
        local col = 6

        -- renk seçimi
        if s.spd < 1 then
            col = 13
        elseif s.spd < 1.5 then
            col = 1
        end

        -- çizim
        if s.spd > 2.45 then
            spr(32, s.x, s.y)
        else
            pset(s.x, s.y, col)
        end
    end
end



function animate_stars()
    
    for i=1, #stars do
        local mystar = stars[i]
        mystar.y = mystar.y + mystar.spd
        if mystar.y>128 then
            mystar.y = mystar.y - 128
        end  
    end
end

function update_game()

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
    if btnp(4) then
            mode = "Start"
            draw_start()
    end

    if bombs == 0 then
        mode = "Over"
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

    animate_stars()

    end

    function draw_game()
        cls()
    starfield()
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

      function draw_start()
        cls(2)

        print("my Awesome Shmup", 34, 40)
        print("press Any Key to Start",24 , 70)
        
    end

    function start_button()
        if btnp(4) then
            local start_time = time()

            if time()  then
                
            end
                start_game()
        end

    end

    function start_game()
        mode = "Game"
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
        starsx = {}
        starsy = {}
        starspd = {}

        for i = 1, 100 do
                add(starsx, rnd(128))
                add(starsy, rnd(128))
                add(starspd, rnd(2)+0.5)
        end

    stars = {}

    for i = 1, 100 do
        local newstar={}
        newstar.x = rnd(128)
        newstar.y = rnd(128)
        newstar.spd = rnd(2)+0.5
        add(stars, newstar)
        end
    end

  
    
    

    -----stars-----



    function game_over()
        cls(8)
        print("game over!", 50, 50, blink())
          
    end

    function blink()
        local eanim = {5,5,5,5,5,5,6,7,7}

        if blinkt > #eanim then
            blinkt = 1
        end
        return eanim[blinkt]
    end


   