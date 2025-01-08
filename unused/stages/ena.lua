local u = false;
local r = 0;
local i =0
local shot = false;
local agent = 1
local health = 0;
local xx = 980;
local yy = 670;
local xx2 = 980;
local yy2 = 670;
local ofs = 20;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()


	makeLuaSprite('BG1', 'H024/ena/ENA-1', 0, 10)
	setLuaSpriteScrollFactor('BG1', 1.0, 0.9);
        setProperty("BG1.scale.x", 1.0);
        setProperty("BG1.scale.y", 1.0);



	makeLuaSprite('BG2', 'H024/ena/ENA-2', 0, 10)
	setLuaSpriteScrollFactor('BG2', 1.0, 0.9);
        setProperty("BG2.scale.x", 1.0);
        setProperty("BG2.scale.y", 1.0);



	makeLuaSprite('BG3', 'H024/ena/ENA-3', 0, 0)
	setLuaSpriteScrollFactor('BG3', 1.0, 1.0);
        setProperty("BG3.scale.x", 1.0);
        setProperty("BG3.scale.y", 1.0);



	makeLuaSprite('BG4', 'H024/ena/OERLAY-4', 0, 0)
	setLuaSpriteScrollFactor('BG4', 1.0, 1.0);
        setProperty("BG4.scale.x", 1.0);
        setProperty("BG4.scale.y", 1.0);
				setBlendMode('BG4', 'add');



	makeLuaSprite('BG5', 'H024/ena/ENA-5', 100, 75)
	setLuaSpriteScrollFactor('BG5', 1.2, 1.2);
        setProperty("BG5.scale.x", 1.0);
        setProperty("BG5.scale.y", 1.0);



	addLuaSprite('BG1', false);
	addLuaSprite('BG2', false);
	addLuaSprite('BG3', false);
	addLuaSprite('BG4', true);
	addLuaSprite('BG5', true);

end
function onUpdatePost(elapsed)

	daElapsed = elapsed * 30
	i = i + daElapsed

	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
     if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.8)
            triggerEvent('Camera Follow Pos',xx,yy)
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            setProperty('defaultCamZoom',0.8)
            triggerEvent('Camera Follow Pos',xx2,yy2)
            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end

end
