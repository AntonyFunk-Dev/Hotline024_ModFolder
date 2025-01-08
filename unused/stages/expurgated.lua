function onCreate()
 precacheImage("h024/expurgated/particle");

 makeLuaSprite("sky", "h024/expurgated/sky", -375, -220);
 setScrollFactor("sky", 0.2, 0.2);
 setProperty("sky.scale.x", 2.5);
 setProperty("sky.scale.y", 2.5);

 makeLuaSprite("rock2", "h024/expurgated/rock2", -1050, -490);
 setScrollFactor("rock2", 0.8, 0.8);
 setProperty("rock2.scale.x", 2.5);
 setProperty("rock2.scale.y", 2.5);

 makeLuaSprite("ground", "h024/expurgated/ground", -1350, -600);
 setProperty("ground.scale.x", 2.5);
 setProperty("ground.scale.y", 2.5);

 if not lowQuality then
  makeLuaSprite("gradoverlay", "h024/expurgated/gradoverlay", -1350, -700);
  setBlendMode("gradoverlay", "add");
  setProperty("gradoverlay.scale.x", 2.5);
  setProperty("gradoverlay.scale.y", 2.5);
 end

 makeLuaSprite("signfront", "h024/expurgated/signfront", -1900, -760);
 setScrollFactor("signfront", 1.4, 1.4);
 setProperty("signfront.scale.x", 2.5);
 setProperty("signfront.scale.y", 2.5);



 addLuaSprite("sky", false);
 addLuaSprite("rock2", false);
 addLuaSprite("ground", false);
 if not lowQuality then addLuaSprite("gradoverlay", true); end
 addLuaSprite("signfront", true);
end

function onCreatePost()
 setProperty("defaultCamZoom", 0.45);
 setGlobalFromScript("scripts/camFollowPos", "camOffsetFollow", 35);
 setGlobalFromScript("scripts/camFollowPos", "bfZoom", 0.45);
 setGlobalFromScript("scripts/camFollowPos", "dadZoom", 0.32);

 setCharFloat({"nikku", "nikku-24", "nikku-jojo", "nikku-classic"}, nil, -150);

 if not lowQuality then runTimer("startParticles", 0.25, 0); end
end

function onTimerCompleted(tag)
 if tag == "startParticles" then
  particlesSpawn("h024/expurgated/particle", getRandomInt(-1500, 1250), 2000, getObjectOrder("ground"));
 end
end



------------------------------------------------------------------------------------



function setCharFloat(char, opts, ofsY)
 if char == nil then return; end
 if opts == nil then opts = {nil, nil, nil}; end
 for i, _ in ipairs(char) do
  if opts[1] ~= nil then setGlobalFromScript("characters/" .. char[i], "charSpeedMult", opts[1]); end
  if opts[2] ~= nil then setGlobalFromScript("characters/" .. char[i], "charSinMult", opts[2]); end
  if opts[3] ~= nil then setGlobalFromScript("characters/" .. char[i], "charDistantY", opts[3]); end
  if ofsY ~= nil then setGlobalFromScript("characters/" .. char[i], "charOffsetY", ofsY); end
 end
end

local lastParticle = {};
local particleCount = 0;
function particlesSpawn(image, x, y, objOrder)
 if x == nil then x = 0; end
 if y == nil then y = 0; end
 particleCount = particleCount + 1;
 if particleCount > 90 then perticleCount = 1; end
 makeLuaSprite("part" .. particleCount, image, x, y);
 if objOrder == nil then
  addLuaSprite("part" .. particleCount);
 else
  setObjectOrder(("part" .. particleCount), objOrder);
 end
 scaleObject("part" .. particleCount, 2.0, 2.0, true);
 setProperty("part" .. particleCount .. ".velocity.y", getRandomInt(-450, -850));
 setProperty("part" .. particleCount .. ".velocity.x", getRandomInt(-50, 50));
 table.insert(lastParticle, "part" .. particleCount);

 startTween("part" .. particleCount, "part" .. particleCount .. ".scale", {x = 0, y = 0}, 3.2, {startDelay = crochet * 0.0052});
end

function onTweenCompleted(t)
 if (stringStartsWith(t, "partScaleX")) or (stringStartsWith(t, "partScaleY")) then
 for i = 1, #lastParticle do
 if (lastParticle[i] ~= nil) then
  if (getProperty(lastParticle[i] .. ".scale.x") == 0) or (getProperty(lastParticle[i] .. ".scale.y") == 0) then
   removeLuaSprite(lastParticle[i], true);
   table.remove(lastParticle, i);
  end
 end
 end
 end
end