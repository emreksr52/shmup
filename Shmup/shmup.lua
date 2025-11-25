function _init()
cls(0)
mode = "Start"
blinkt = 0
real_time = 0
fps = 0
buls = {}
enemies = {}
bulnum = 1
create_enemies()
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
    spr(ship.spr, ship.x, ship.y)
    
end

function draw_flame(flamespr)
    spr(flamespr, ship.x, ship.y + 8)
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
        if s.y>128 then
            del(stars,s)
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

     ship.sx = 0
    ship.sy = 0
    ship.spr = 2


     for i=#buls,1,-1 do
            local mybul = buls[i]
            mybul.y = mybul.y - 4
            if mybul.y < 4 then
                del(buls,mybul)
            end
        end

    if btn(0) then
        ship.sx = -2
        ship.spr = 1
    end

    if btn(1) then
        ship.sx = 2
        ship.spr = 3
    end

    if btn(2) then
        ship.sy = -2
    end

    if btn(3) then
        ship.sy = 2
    end

     if btnp(5) then

        local newbul = {}
        newbul.x = ship.x
        newbul.y = ship.y - 5
        newbul.spr = 16
       
        add(buls, newbul)

        spr(002, ship.x, ship.y)
        muzzle = 5
        sfx(0)
        score = score + 100
        --bombs = bombs - 1
    end
    if btnp(4) then
            mode = "Start"
            draw_start()
    end

    if bombs == 0 then
        mode = "Over"
    end


    ship.x = ship.x + ship.sx
    ship.y = ship.y + ship.sy

    if ship.x>120 then
        ship.x = 120
    end

    if ship.x < 0 then
        ship.x = 0
    end

     if ship.y>120 then
        ship.y = 120
    end

    if ship.y < 0 then
        ship.y = 0
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
    move_enemies()

    end

    function draw_game()
        cls()
    starfield()
    draw_ship(ship.spr)
    draw_flame(flamespr)
    draw_bullets()
    draw_enemies()
    
    if muzzle > 0  then
        circfill(ship.x + 4, ship.y - 1,muzzle, 7)
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
        ship={}
        ship.x = 64
        ship.y = 64
        ship.sx = 0
        ship.sy = 0
        ship.spr = 2
        mini = 99
    
        bullx = 64
        bully= -10
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

    function draw_bullets()
        for i=1,#buls do
            local mybul = buls[i]
            drwmyspr(mybul)
        end
        
    end

    function draw_enemies()

        for i=1,#enemies do
            local myen = enemies[i]
            drwmyspr(myen)
        end
        
    end


    function create_enemies()
            for i=0,120, 12 do
            local myen = {}
            myen.x = i + 10
            myen.y = 5
            myen.spr = 36
            add(enemies,myen)
        end
    end

    function move_enemies()

        for myen in all(enemies) do
            myen.y += 1
            myen.spr +=0.5
             if myen.spr >= 43 then
                myen.spr = 36
            end

            if myen.y >128 then
            del(enemies,myen)
        end
        end
    end

    function drwmyspr(myspr)
        spr(myspr.spr,myspr.x, myspr.y)
    end



   