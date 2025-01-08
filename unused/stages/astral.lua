function onCreate()
 setProperty("defaultCamZoom", 0.7);

 makeLuaSprite("BG", "h024/matzu/BG", 0, 0)
 precacheImage("h024/matzu/2/BG1");

 makeLuaSprite("DES", "h024/matzu/DES", 0, 0)
 precacheImage("h024/matzu/2/desk2");

 makeLuaSprite("idk", "h024/matzu/2/idk", 0, -260)

 makeLuaSprite("ground", "h024/matzu/2/ground", 0, 0)

 makeLuaSprite("messages", "h024/matzu/2/messages", 0, 0)

 makeLuaSprite("door", "h024/matzu/2/door", 0, 0)

 makeLuaSprite("PLAMTS", "h024/matzu/PLAMTS", 30, 0)
 precacheImage("h024/matzu/2/PLAMTS2");


 addLuaSprite("BG", false);
 addLuaSprite("DES", true);
 addLuaSprite("PLAMTS", true);
end

function onCreatePost()
 runHaxeCode("game.gf.kill();");

 setProperty("healthBar.visible", false);
 for i = 1, 2 do setProperty("iconP" .. i .. ".visible", false); end


 setGlobalFromScript("scripts/camFollowPos", "camOffsetFollow", 35);
 setGlobalFromScript("scripts/camFollowPos", "bfOffsetFollow", 8.75);
 setGlobalFromScript("scripts/camFollowPos", "bfZoom", 0.7);
 setGlobalFromScript("scripts/camFollowPos", "dadZoom", 0.8);
 setGlobalFromScript("scripts/camFollowPos", "bfPos", {960, 540});
 setGlobalFromScript("scripts/camFollowPos", "dadPos", {960, 520});
end

function onEvent(n, v1, v2)
 if n == "Astral Event" then
  if v2 == "0" then
   loadGraphic("BG", "h024/matzu/2/BG1");
   addLuaSprite("idk");
   addLuaSprite("ground");
   addLuaSprite("messages");
   addLuaSprite("door");
   loadGraphic("DES", "h024/matzu/2/desk2");
   loadGraphic("PLAMTS", "h024/matzu/2/PLAMTS2");
  elseif v2 == "1" then
   loadGraphic("BG", "h024/matzu/BG");
   removeLuaSprite("idk");
   removeLuaSprite("ground");
   removeLuaSprite("messages");
   removeLuaSprite("door");
   loadGraphic("DES", "h024/matzu/DES");
   loadGraphic("PLAMTS", "h024/matzu/PLAMTS");
  end
 end
end