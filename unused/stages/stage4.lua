luaDebugMode = true;

function onCreate()
 makeLuaSprite("bg", "h024/stage4/bg", -1830, -1180);
 setScrollFactor("bg", 0.75, 0.75);
 scaleObject("bg", 1.8, 1.8, true);

 makeLuaSprite("buildings", "h024/stage4/buildings", -1990, -1280);
 setScrollFactor("buildings", 0.9, 0.9);
 scaleObject("buildings", 1.8, 1.8, true);

 makeLuaSprite("buildings2", "h024/stage4/buildings2", -2030, -1280);
 setScrollFactor("buildings2", 0.95, 0.95);
 scaleObject("buildings2", 1.8, 1.8, true);

 makeLuaSprite("ground", "h024/stage4/ground", -2070, -1280);
 setScrollFactor("ground", 1.0, 1.0);
 scaleObject("ground", 1.8, 1.8, true);

 if shadersEnabled then
  makeLuaSprite("overlay3", "h024/stage4/overlay3", -2070, -1280);
  scaleObject("overlay3", 1.8, 1.8, true);
  setBlendMode("overlay3", "multiply");

  makeLuaSprite("overlay2", "h024/stage4/overlay2", -2190, -1330);
  setScrollFactor("overlay2", 1.1, 1.1);
  scaleObject("overlay2", 1.8, 1.8, true);
  setBlendMode("overlay2", "add");

  makeLuaSprite("overlay1", "h024/stage4/overlay1", -2190, -1330);
  setScrollFactor("overlay1", 1.1, 1.1);
  scaleObject("overlay1", 1.8, 1.8, true);
  setBlendMode("overlay1", "add");
 end

 makeLuaSprite("bushes", "h024/stage4/bushes", -2190, -1330);
 setScrollFactor("bushes", 1.2, 1.2);
 scaleObject("bushes", 1.8, 1.8, true);



 addLuaSprite("bg", false);
 addLuaSprite("buildings", false);
 addLuaSprite("buildings2", false);
 addLuaSprite("ground", false);
 if shadersEnabled then
  addLuaSprite("overlay3", false);
  addLuaSprite("overlay2", true);
  addLuaSprite("overlay1", true);
 end
 addLuaSprite("bushes", true);
end

function onCreatePost()
 setGlobalFromScript("scripts/camFollowPos", "camOffsetFollow", 35);
 setGlobalFromScript("scripts/camFollowPos", "bfZoom", 0.65);
 setGlobalFromScript("scripts/camFollowPos", "dadZoom", 0.55);

 if not lowQuality then
  makeCharReflect("bfReflect", "boyfriend");
  if shadersEnabled then setBlendMode("bfReflect", "add"); end
  setProperty("bfReflect.alpha", (shadersEnabled and 0.7 or 0.5));
  setProperty("bfReflect.flipY", true);

  makeCharReflect("dadReflect", "dad");
  if shadersEnabled then setBlendMode("dadReflect", "add"); end
  setProperty("dadReflect.alpha", (shadersEnabled and 0.7 or 0.5));
  setProperty("dadReflect.flipY", true);

  makeCharReflect("gfReflect", "gf");
  if shadersEnabled then setBlendMode("gfReflect", "add"); end
  setProperty("gfReflect.alpha", (shadersEnabled and 0.7 or 0.5));
  setProperty("gfReflect.flipY", true);
 end
end

function onUpdatePost(elapsed)
 if not lowQuality then
  updateCharReflect("bfReflect", "boyfriend", getProperty("boyfriend.height") * 2 - 90);
  updateCharReflect("dadReflect", "dad", 700);
  updateCharReflect("gfReflect", "gf", -85);
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
    resetCharReflect("gfReflect", "gf");
    if shadersEnabled then setBlendMode("gfReflect", "add"); end
    setProperty("gfReflect.alpha", 0.7);
    setProperty("gfReflect.flipY", true);
   else
    resetCharReflect("bfReflect", "boyfriend");
    if shadersEnabled then setBlendMode("bfReflect", "add"); end
    setProperty("bfReflect.alpha", 0.7);
    setProperty("bfReflect.flipY", true);
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
   game.remove(getVar("]].. tag ..[["));
   removeVar("]].. tag ..[[");
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

function setCharFloat(char, opts, ofsY)
 if char == nil then return; end
 if opts == nil then opts = {nil, nil, nil}; end
 for i, _ in ipairs(char) do
  local charLua = "characters/" .. char[i];
  if checkFileExists(charLua .. ".lua") then
   if opts[1] ~= nil then setGlobalFromScript(charLua, "charSpeedMult", opts[1]); end
   if opts[2] ~= nil then setGlobalFromScript(charLua, "charSinMult", opts[2]); end
   if opts[3] ~= nil then setGlobalFromScript(charLua, "charDistantY", opts[3]); end
   if ofsY ~= nil then setGlobalFromScript(charLua, "charOffsetY", ofsY); end
  else
   if luaDebugMode then debugPrint("ERROR setCharFloat: The character's lua file '".. char[i] .."' does not exist (check the location '".. charLua ..".lua' if necessary)", "FF0000"); end
   return;
  end
 end
end