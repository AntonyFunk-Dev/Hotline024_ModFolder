
local u = false;
local r = 0;
local i =0
local shot = false;
local agent = 1
local health = 0;
local xx = 800;
local yy = -570;
local xx2 = 200;
local yy2 = -270;
local ofs = 55;
local followchars = true;
local del = 0;
local del2 = 0;
local stopMoving = false;

function onCreate()
        setProperty('defaultCamZoom',0.45)
        makeLuaSprite('bartop','',0,-30)
        makeGraphic('bartop',1280,100,'000000')
        addLuaSprite('bartop',true)
        setObjectCamera('bartop','hud')
        setScrollFactor('bartop',0,0)

        makeLuaSprite('barbot','',0,650)
        makeGraphic('barbot',1280,100,'000000')
        addLuaSprite('barbot',true)
        setScrollFactor('barbot',0,0)
        setObjectCamera('barbot','hud')



        makeLuaSprite('BG1', 'H024/xigmund/bg', -400, -500);
	setLuaSpriteScrollFactor('BG1', 0.4, 0.4);
        setProperty("BG1.scale.x", 2.0);
        setProperty("BG1.scale.y", 2.0);



        makeLuaSprite('BG2', 'H024/xigmund/sum', 250, -900);
	setLuaSpriteScrollFactor('BG2', 0.4, 0.4);
        setProperty("BG2.scale.x", 1.2);
        setProperty("BG2.scale.y", 1.2);



        makeLuaSprite('BG3', 'H024/xigmund/sum-2', -450, -100);
	setLuaSpriteScrollFactor('BG3', 0.4, 0.4);
        setProperty("BG3.scale.x", 1.2);
        setProperty("BG3.scale.y", 1.2);



        makeLuaSprite('BG4', 'H024/xigmund/PlaBlue', -1100, 150);
	setLuaSpriteScrollFactor('BG4', 0.4, 0.4);
        setProperty("BG4.scale.x", 1.2);
        setProperty("BG4.scale.y", 1.2);



        makeLuaSprite('BG5', 'H024/xigmund/PlaRed', 1100, -1200);
	setLuaSpriteScrollFactor('BG5', 0.4, 0.4);
        setProperty("BG5.scale.x", 1.2);
        setProperty("BG5.scale.y", 1.2);



	addLuaSprite('BG1', false);
	addLuaSprite('BG2', false);
	addLuaSprite('BG3', false);
	addLuaSprite('BG4', false);
	addLuaSprite('BG5', false);



        runTimer('cj',1)

end
function onCreatePost()

   --makeLuaTexts
   makeLuaText('Watermark', 'Port by Thepotra', 0, 15, getProperty('healthBarBG.y') + 30);

  
   --addLuaText
   addLuaText('Watermark')


   --Text fonts
   setTextFont('scoreTxt', 'Metropolische_2016.ttf')
   setTextFont('healthCounter', 'Metropolische_2016.ttf')
   setTextFont('timeTxt', 'PhantomMuff Full Letters 1.1.5.ttf')
   setTextFont('botplayTxt', 'Metropolische_2016.ttf')
   setTextFont('judgementCounter', 'Metropolische_2016.ttf')
   setTextFont('Watermark', 'Metropolische_2016.ttf');

   
   --Text sizes
   setTextSize('Watermark', 20);
   setTextSize('scoreTxt', 20);
   setTextSize('healthCounter', 20);
   setTextSize('timeTxt', 20);
   setTextSize('botplayTxt', 34);
   setTextSize('judgementCounter', 20);

end
function onUpdate(elapsed)

	daElapsed = elapsed * 30
	i = i + daElapsed


	if stopMoving == false then
		setProperty('dad.y', (math.sin(i/20)*40) - 800)
		setProperty('boyfriend.y', (math.sin(i/16)*50) - 500)
	end

	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
     if followchars == true then
        if mustHitSection == false then
            setProperty('defaultCamZoom',0.45)
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
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else
      
            setProperty('defaultCamZoom',0.55)
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
            if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
end

function onGameOver()
	stopMoving = true;
end
function onTimerCompleted(t,l,ll)
                if t == 'cj' then
		setProperty('BG5.y', -1200)
		doTweenX('BG5','BG5', -100, 30.0,'cubeInOut')
		setProperty('BG4.x', -1100)
		doTweenX('BG4','BG4', -1600, 20.0,'cubeInOut')

       end
end