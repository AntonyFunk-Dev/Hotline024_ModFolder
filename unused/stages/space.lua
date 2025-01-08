function onCreate()
 setProperty("defaultCamZoom", 0.55);

 makeLuaSprite('s1', 'h024/stage3/s1', -1346, -639)
 setScrollFactor('s1', 0.1, 0.1);
 scaleObject("s1", 1.85, 1.85);

 makeLuaSprite('s2', 'h024/stage3/s2', -1518, -552)
 setScrollFactor('s2', 0.1, 0.1);
 scaleObject("s2", 1.8, 1.8);

 makeLuaSprite('s3', 'h024/stage3/s3', -1714, -686)
 setScrollFactor('s3', 0.35, 0.35);
 scaleObject("s3", 1.9, 1.9);

 makeLuaSprite('s4', 'h024/stage3/s4', -2070, -750)
 scaleObject("s4", 1.75, 1.75);
 if not lowQuality then setBlendMode('s4', 'add'); end

 makeLuaSprite('s5', 'h024/stage3/s5', -1436, -664)
 setScrollFactor('s5', 0.4, 0.4);
 scaleObject("s5", 1.6, 1.6);

 makeLuaSprite('s6', 'h024/stage3/s6', -1704, -831)
 setScrollFactor('s6', 0.6, 0.6);
 scaleObject("s6", 1.65, 1.65);

 makeLuaSprite('s7', 'h024/stage3/s7', -1600, -695)
 setScrollFactor('s7', 0.65, 0.65);
 scaleObject("s7", 1.62, 1.62);

 makeLuaSprite('s8', 'H024/stage3/s8', -1900, -900)
 setScrollFactor('s8', 0.85, 0.85);
 scaleObject("s8", 1.75, 1.75);

 makeLuaSprite('s9', 'h024/stage3/s9', -2022, -965)
 scaleObject("s9", 1.7, 1.7);

 makeLuaSprite('s10', 'h024/stage3/s10', -2348, -1012)
 scaleObject("s10", 1.8, 1.8);
 setScrollFactor('s10', 1.1, 1.1);



 addLuaSprite('s1', false);
 addLuaSprite('s2', false);
 addLuaSprite('s3', false);
 addLuaSprite('s4', false);
 addLuaSprite('s5', false);
 addLuaSprite('s6', false);
 addLuaSprite('s7', false);
 addLuaSprite('s8', false);
 addLuaSprite('s9', false);
 addLuaSprite('s10', true);
end

function onCreatePost()
 setScrollFactor('gf', 0.85, 0.85);
 setObjectOrder('gfGroup', getObjectOrder('s9'));

 setGlobalFromScript("scripts/camFollowPos", "camOffsetFollow", 35);
 setGlobalFromScript("scripts/camFollowPos", "bfOffsetPos", {-200, -100});
 setGlobalFromScript("scripts/camFollowPos", "dadOffsetPos", {100, 100});
 setGlobalFromScript("scripts/camFollowPos", "bfZoom", 0.55);
 setGlobalFromScript("scripts/camFollowPos", "dadZoom", 0.45);

 setCharFloat({"nikku", "nikku-24", "nikku-jojo", "nikku-classic"}, nil, -120);
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