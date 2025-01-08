luaDebugMode = true;
camZooming = false;
camHUDZoom = 0.8;

function onCreatePost()
 makeLuaSprite("UpperBar");
 makeGraphic("UpperBar", screenWidth * 2, screenHeight * 2, '000000');
 screenCenter("UpperBar", 'x');
 setObjectCamera("UpperBar", 'camHUD');
 addLuaSprite("UpperBar");
 setProperty("UpperBar.y", getProperty("UpperBar.y") - getProperty("UpperBar.height"));

 makeLuaSprite("LowerBar");
 makeGraphic("LowerBar", screenWidth * 2, screenHeight * 2, '000000');
 screenCenter("LowerBar", 'x');
 setObjectCamera("LowerBar", 'camHUD');
 addLuaSprite("LowerBar");
 setProperty("LowerBar.y", getProperty("LowerBar.y") + getProperty("LowerBar.height") / 2);

 setProperty("camHUD.zoom", camHUDZoom);
 makeLuaSprite("ui", 'ui', 0, -150);
 scaleObject("ui", 1.25, 1.25, false);
 setObjectCamera("ui", 'camHUD');
 screenCenter("ui", 'x');
 addLuaSprite("ui");
 setProperty("iconP1.y", getProperty("iconP1.y"))
 setProperty("iconP2.y", getProperty("iconP2.y"))
 setProperty("scoreTxt.size", 15)
 setProperty("scoreTxt.antialiasing", true)
 setProperty("timeBar.visible", false)

 for i = 0, 7 do
  setPropertyFromGroup("strumLineNotes", i, "y", getPropertyFromGroup("strumLineNotes", i, "y") - 65)
 end

 for i = 0, 3 do
  setPropertyFromGroup("playerStrums", i, "x", getPropertyFromGroup("playerStrums", i, "x") + 100)
  --setPropertyFromGroup("playerStrums", i, "x", getPropertyFromGroup("playerStrums", i, "x") + 8)
  setPropertyFromGroup("opponentStrums", i, "x", getPropertyFromGroup("opponentStrums", i, "x") - 89)
 end
end

function onUpdatePost(elapsed)
 runHaxeCode([[
  var mult:Float = FlxMath.lerp(0.4, game.iconP1.scale.x, Math.exp(-FlxG.elapsed * 10 * game.playbackRate));
  game.iconP1.scale.set(mult, mult);
  game.iconP1.updateHitbox();

  var mult:Float = FlxMath.lerp(0.4, game.iconP2.scale.x, Math.exp(-FlxG.elapsed * 10 * game.playbackRate));
  game.iconP2.scale.set(mult, mult);
  game.iconP2.updateHitbox();

  debugPrint(mult);

  var iconOffset:Int = 30;
  game.iconP1.x = game.healthBar.barCenter + (150 * game.iconP1.scale.x - 150) / 2 - iconOffset;
  game.iconP2.x = game.healthBar.barCenter - (150 * game.iconP2.scale.x) / 2 - iconOffset * 2;

  game.camZooming = false;
  FlxG.camera.zoom = FlxMath.lerp(game.defaultCamZoom, FlxG.camera.zoom, Math.exp(-FlxG.elapsed * 3.125 * game.camZoomingDecay * game.playbackRate));
  game.camHUD.zoom = FlxMath.lerp(]] .. camHUDZoom .. [[, game.camHUD.zoom, Math.exp(-FlxG.elapsed * 3.125 * game.camZoomingDecay * game.playbackRate));
 ]])
end

function onSectionHit()
 if camZooming then
  setProperty("camGame.zoom", getProperty("camGame.zoom") + 0.015 * (getProperty("defaultCamZoom") * 2) * getProperty("camZoomingMult"))
  setProperty("camHUD.zoom", getProperty("camHUD.zoom") + 0.03 * camHUDZoom * getProperty("camZoomingMult"))
 end
end

function onBeatHit()
scaleObject("iconP1", 0.8, 0.8)
scaleObject("iconP2", 0.8, 0.8)
end

function opponentNoteHit()
 camZooming = true
 setVar("camZooming", camZooming);
end