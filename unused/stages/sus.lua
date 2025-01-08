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
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;
function onCreate()
        setProperty('defaultCamZoom',0.8)
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



        makeLuaSprite('BG1', 'H024/sus/SUS1', -180, -175);
	setLuaSpriteScrollFactor('BG1', 0.5, 0.5);
        setProperty("BG1.scale.x", 1.0);
        setProperty("BG1.scale.y", 1.0);



        makeLuaSprite('BG2', 'H024/sus/SUS2', -5, 0);
	setLuaSpriteScrollFactor('BG2', 1.0, 1.0);
        setProperty("BG2.scale.x", 1.0);
        setProperty("BG2.scale.y", 1.0);



        makeLuaSprite('BG3', 'H024/sus/SUS3', 25, 0);
	setLuaSpriteScrollFactor('BG3', 1.25, 1.25);
        setProperty("BG3.scale.x", 1.0);
        setProperty("BG3.scale.y", 1.0);




	addLuaSprite('BG1', false);
	addLuaSprite('BG2', false);
	addLuaSprite('BG3', true);



end
function onCreatePost()
 runHaxeCode("game.gf.kill();");

 setGlobalFromScript("scripts/camFollowPos", "camOffsetFollow", 35);
 setGlobalFromScript("scripts/camFollowPos", "bfZoom", 0.65);
 setGlobalFromScript("scripts/camFollowPos", "dadZoom", 0.55);

 if not lowQuality then
  --makeCharReflect("bfReflect", "boyfriend");
  --if shadersEnabled then setBlendMode("bfReflect", "add"); end
  --setProperty("bfReflect.alpha", 0.7);
  --setProperty("bfReflect.flipY", true);

  makeCharReflect("dadReflect", "dad");
  if shadersEnabled then setBlendMode("dadReflect", "add"); end
  setProperty("dadReflect.alpha", 0.5);
  setProperty("dadReflect.flipY", true);

  --makeCharReflect("gfReflect", "gf");
  --if shadersEnabled then setBlendMode("gfReflect", "add"); end
  --setProperty("gfReflect.alpha", 0.7);
  --setProperty("gfReflect.flipY", true);
 end
end

function onUpdatePost(elapsed)
 if not lowQuality then
  --updateCharReflect("bfReflect", "boyfriend", getProperty("boyfriend.height") * 2 - 90);
  updateCharReflect("dadReflect", "dad", (getProperty("dad.height") * 6.5) - 60);
  --updateCharReflect("gfReflect", "gf", -85);
 end

 
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
   
         setProperty('defaultCamZoom',0.8)
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

function onEvent(n, v1, v2)
 if n == "Change Character" then
  local v1 = string.lower(v1);
  if not lowQuality then
   if v1 == "dad" or v1 == "opponent" or v1 == "1" then
    resetCharReflect("dadReflect", "dad");
    if shadersEnabled then setBlendMode("dadReflect", "add"); end
    setProperty("dadReflect.alpha", 0.7);
    setProperty("dadReflect.flipY", true);
   elseif v1 == "gf" or v1 == "girlfriend" or v1 == "2" then
    --resetCharReflect("gfReflect", "gf");
    --if shadersEnabled then setBlendMode("gfReflect", "add"); end
    --setProperty("gfReflect.alpha", 0.7);
    --setProperty("gfReflect.flipY", true);
   else
    --resetCharReflect("bfReflect", "boyfriend");
    --if shadersEnabled then setBlendMode("bfReflect", "add"); end
    --setProperty("bfReflect.alpha", 0.7);
    --setProperty("bfReflect.flipY", true);
   end
  end
 end
end



------------------------------------------------------------------------------------



function makeCharReflect(tag, char)
 if char == "boyfriend" or char == "dad" or char == "gf" then
  runHaxeCode([[
   var ]].. tag ..[[ = new Character(game.]].. char ..[[.x, game.]].. char ..[[.y, game.]].. char ..[[.curCharacter, game.]].. char ..[[.isPlayer);
   game.insert(game.members.indexOf(game.]].. char ..[[Group), ]].. tag ..[[);
   setVar("]].. tag ..[[", ]].. tag ..[[);
  ]]);
 else
  if luaDebugMode then debugPrint("ERROR makeCharReflect: the CHAR '".. char .."' is incorrect (only 'boyfriend', 'dad' or 'gf')", "FF0000"); end
  return;
 end
end

function resetCharReflect(tag, char)
 if char == "boyfriend" or char == "dad" or char == "gf" then
  runHaxeCode([[
   game.remove(game.getLuaObject("]].. tag ..[["));
   removeVar("]].. tag ..[[", game.getLuaObject("]].. tag ..[["));
   var ]].. tag ..[[ = new Character(game.]].. char ..[[.x, game.]].. char ..[[.y, game.]].. char ..[[.curCharacter, game.]].. char ..[[.isPlayer);
   game.insert(game.members.indexOf(game.]].. char ..[[Group), ]].. tag ..[[);
   setVar("]].. tag ..[[", ]].. tag ..[[);
  ]]);
 else
  if luaDebugMode then debugPrint("ERROR makeCharReflect: the CHAR '".. char .."' is incorrect (only 'boyfriend', 'dad' or 'gf')", "FF0000"); end
  return;
 end
end

function updateCharReflect(tag, char, ofsY)
 if ofsY == nil then ofsY = 0; end
 if getProperty(tag) ~= nil then
  if char == "boyfriend" or char == "dad" or char == "gf" then
   setProperty(tag .. ".animation.frameName", getProperty(char .. ".animation.frameName"));
   setProperty(tag .. ".offset.x", getProperty(char .. ".offset.x"));
   setProperty(tag .. ".offset.y", getProperty(char .. ".frameHeight") * getProperty(char .. ".scale.y") - getProperty(char .. ".offset.y"));
   setProperty(tag .. ".y", -getProperty(char .. ".y") + ofsY);
  else
   if luaDebugMode then debugPrint("ERROR updateCharReflect: the CHAR '".. char .."' is incorrect (only 'boyfriend', 'dad' or 'gf')", "FF0000"); end
   return;
  end
 else
  if luaDebugMode then debugPrint("ERROR updateCharReflect: the TAG '".. tag .."' does not exist", "FF0000"); end
  return;
 end
end