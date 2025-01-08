function onCreate()
    runHaxeCode([[
     import flixel.addons.display.FlxBackdrop; 

     var mallBG = new FlxBackdrop(Paths.image("h024/momogogo/bg"), 0x01);
     mallBG.setPosition(0, 150);
     mallBG.velocity.set(300, 0);
     addBehindGF(mallBG);
    ]]);
end

function onCreatePost()
  runHaxeCode("game.gf.kill();");
 setProperty("defaultCamZoom", 0.6);
 setGlobalFromScript("scripts/camFollowPos", "bfPos", {nil, 670});
 setGlobalFromScript("scripts/camFollowPos", "dadPos", {nil, 670});
end