pico-8 cartridge // http://www.pico-8.com
version 32
__lua__



function _init()
    game_over = false
    make_cave()
    make_player()
end

function _update()
    if (not game_over) then
        update_cave()
        move_player()
        check_hit()
    end
end

function _draw()
    cls()
    draw_cave()
    draw_player()

end

function make_player()
    player={}
    player.x = 24 --position
    player.y = 60
    player.dy = 0 --fall speed
    player.rise = 1 --sprites
    player.fall = 2
    player.dead = 3
    player.speed = 2 --flyspeed
    player.score = 0
end

function draw_player()
    if(game_over) then
        spr(player.dead,player.x,player.y)
    elseif (player.dy<0) then
        spr(player.rise,player.x,player.y)
    else
        spr(player.fall, player.x, player.y)
    end

end

function move_player()
    gravity = 0.2 
    player.dy += gravity 

    --jump
    if (btnp(2)) then
        player.dy -=5
    end

    --move
    player.y += player.dy

end

function make_cave()
    cave = {{["top"]=5,["btm"]=119}}
    top=45
    btm =85
end

function update_cave()
    --remove
    if (#cave>player.speed) then
        for i=1, player.speed do 
            del(cave,cave[1])
        end
    end

    --add
    while (#cave<128) do
        local col ={}
        local up = flr(rnd(7)-3)
        local dwn=flr(rnd(7)-3)
        col.top=mid(3,cave[#cave].top+up, top)
        col.btm=mid(btm,cave[#cave].btm+dwn,124)
        add(cave,col)
    end
end

function draw_cave()
    top_color=5
    btm_color=5
    for i=1, #cave do
        line(i-1,0,i-1,cave[i].top, top_color)
        line(i-1,127,i-1,cave[i].btm, btm_color)
    end

end

function check_hit()
    for i = player.x,player.x+7 do
        if (cave[i+1].top> player.y or cave[i+1].btm< player.y+7) then
            game_over = true
        end
    end
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000007776000077760000888e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700007070000070700000808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000007776000070700000888e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000007706000077060000880e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000770000007700000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
