function onCreatePost()
 --runHaxeCode("game.gf.kill();");

-- setGlobalFromScript("scripts/camFollowPos", "camOffsetFollow", 35);
 --setGlobalFromScript("scripts/camFollowPos", "bfZoom", 0.65);
 --setGlobalFromScript("scripts/camFollowPos", "dadZoom", 0.55);

 makeLuaSprite('bg', 'h024/ddto/DDLC-1', -380, -270);
 addLuaSprite('bg');

 if not lowQuality then
  --makeCharReflect("bfReflect", "boyfriend");
  --if shadersEnabled then setBlendMode("bfReflect", "add"); end
  --setProperty("bfReflect.alpha", 0.7);
  --setProperty("bfReflect.flipY", true);

  makeCharReflect("dadReflect", "dad");
  if shadersEnabled then setBlendMode("dadReflect", "add"); end
  setProperty("dadReflect.alpha", 0.1);
  setProperty("dadReflect.flipY", true);

  makeCharReflect("gfReflect", "gf");
  if shadersEnabled then setBlendMode("gfReflect", "add"); end
  setProperty("gfReflect.alpha", 0.1);
  setProperty("gfReflect.flipY", true);
 end
end

function onUpdatePost(elapsed)
 if not lowQuality then
  --updateCharReflect("bfReflect", "boyfriend", getProperty("boyfriend.height") * 2 - 90);
  updateCharReflect("dadReflect", "dad", 1320);
  updateCharReflect("gfReflect", "gf", 1300);
 end

 setProperty('camGame.zoom', 0.7)
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