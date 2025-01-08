local optionKey = "C"; -- key name for Menu Options

local dirObjects = "pause/";
local tweenItems = {}
local menuItems = {};
local menuItemsOG = {"resume", "restart", "botplay", "practice", "exit"};
local menuSprites = {"overlay", "cubes1", "cubes2", "sidebar", "resume", "restart", "botplay", "practice", "exit", "endsong", "skiptime"};

local curSelected = 1;
local curTime = math.max(0, getPropertyFromClass('backend.Conductor', 'songPosition'));

for i = 1, #menuSprites do precacheImage(dirObjects .. menuSprites[i]); end


function onCustomSubstateCreate(name)
 if name == "h024PauseSubstate" then
  addHaxeLibrary("FlxStringUtil", 'flixel.util'); 
  menuPlaySound("confirmMenu");
  if getPropertyFromClass("states.PlayState", "chartingMode") then
    tableInsert(menuItemsOG, #menuItemsOG + 1, "endsong");
   if not getPropertyFromClass("states.PlayState", "instance.startingSong") then
    tableInsert(menuItemsOG, #menuItemsOG + 1, "skiptime");
   end
  end

  menuItems = menuItemsOG;

  for i = 1, #menuSprites do
   makeLuaSprite(menuSprites[i], dirObjects .. menuSprites[i]);
   setCamMenu(menuSprites[i]);
   insertToCustomSubstate(menuSprites[i]);
   if menuSprites[i] == "overlay" then 
    setProperty("overlay.alpha", 0);
   elseif menuSprites[i] == "cubes1" then
    spritePosition("cubes1", "right");
   elseif menuSprites[i] == "cubes2" then
    spritePosition("cubes2", "left");
   elseif menuSprites[i] == "sidebar" then
    spritePosition("sidebar", "left");
   elseif menuSprites[i] == "endsong" then
    spritePosition("endsong", "left");
   elseif menuSprites[i] == "skiptime" then
   spritePosition("skiptime", "left");
   end
  end
  for i = 1, #menuItems do spritePosition(menuItems[i], "left"); end

  makeLuaText("levelInfo", songName, 0, 20, 15);
  setTextSize("levelInfo", 32);
  setCamMenu("levelInfo");

  makeLuaText("levelDifficulty", difficultyName, 0, 20, 15 + 32);
  setTextSize("levelDifficulty", 32);
  setCamMenu("levelDifficulty");

  makeLuaText("blueballedTxt", "Blueballed: " .. getPropertyFromClass("states.PlayState", "deathCounter"), 0, 20, 15 + 64);
  setTextSize("blueballedTxt", 32);
  setCamMenu("blueballedTxt");

  makeLuaText("optionMenuTxt", "Press " .. optionKey .. " to access the Options Menu.");
  setTextSize("optionMenuTxt", 20);
  setCamMenu("optionMenuTxt");
  setProperty("optionMenuTxt.x", 10);
  setProperty("optionMenuTxt.y", screenHeight - (getProperty("optionMenuTxt.height") + 5));

  makeLuaText("botplayText", "BOTPLAY", 0, 20, 15 + 101);
  setTextSize("botplayText", 32);
  setCamMenu("botplayText");
  setProperty("botplayText.x", screenWidth - (getProperty("botplayText.width") + 20));
  setProperty("botplayText.y", screenHeight - (getProperty("botplayText.height") + (getPropertyFromClass("states.PlayState", "chartingMode") and 50 or 20)));
  setProperty("botplayText.visible", getPropertyFromClass("states.PlayState", "instance.cpuControlled"));

  makeLuaText("practiceText", "PRACTICE MODE", 0, 20, 15 + 101);
  setTextSize("practiceText", 32);
  setCamMenu("practiceText");
  setProperty("practiceText.x", screenWidth - (getProperty("practiceText.width") + 20));
  setProperty("practiceText.visible", getPropertyFromClass("states.PlayState", "instance.practiceMode"));

  makeLuaText("chartingText", "CHARTING MODE", 0, 20, 15 + 101);
  setTextSize("chartingText", 32);
  setCamMenu("chartingText");
  setProperty("chartingText.x", screenWidth - (getProperty("chartingText.width") + 20));
  setProperty("chartingText.y", screenHeight - (getProperty("chartingText.height") + 20));
  setProperty("chartingText.visible", getPropertyFromClass("states.PlayState", "chartingMode"));

  runHaxeCode([[
   CustomSubstate.instance.add(game.getLuaObject("levelInfo"));
   CustomSubstate.instance.add(game.getLuaObject("levelDifficulty"));
   CustomSubstate.instance.add(game.getLuaObject("blueballedTxt"));
   CustomSubstate.instance.add(game.getLuaObject("optionMenuTxt"));
   CustomSubstate.instance.add(game.getLuaObject("botplayText"));
   CustomSubstate.instance.add(game.getLuaObject("practiceText"));
   CustomSubstate.instance.add(game.getLuaObject("chartingText"));
  ]]);

  setProperty("blueballedTxt.alpha", 0);
  setProperty("levelDifficulty.alpha", 0);
  setProperty("levelInfo.alpha", 0);

  setProperty("levelInfo.x", screenWidth - (getProperty("levelInfo.width") + 20));
  setProperty("levelDifficulty.x", screenWidth - (getProperty("levelDifficulty.width") + 20));
  setProperty("blueballedTxt.x", screenWidth - (getProperty("blueballedTxt.width") + 20));

  startTween("levelInfo", "levelInfo", {alpha = 1, y = 20}, 0.4, {ease = "quartInOut", startDelay = 0.3});
  startTween("levelDifficulty", "levelDifficulty", {alpha = 1, y = getProperty("levelDifficulty.y") + 5}, 0.4, {ease = "quartInOut", startDelay = 0.5});
  startTween("blueballedTxt", "blueballedTxt", {alpha = 1, y = getProperty("blueballedTxt.y") + 5}, 0.4, {ease = "quartInOut", startDelay = 0.7});

  regenMenu();
  tweenMenu();
 end
end

local holdTime = 0;
local cantUnPause = 0.1;
function onCustomSubstateUpdate(name, elapsed)
 if name == "h024PauseSubstate" then
  cantUnPause = cantUnPause - elapsed;
 end
end

local daSelected;
function onCustomSubstateUpdatePost(name, elapsed)
 if name == "h024PauseSubstate" then
  if keyJustPressed("BACK") then
   closeCustomSubstate();
   return;
  end

  updateSkipTextStuff();

  if curSelected >= 1 and curSelected <= #menuItems then
    optionSelected(menuItems[curSelected]);
  end
  daSelected = menuItems[curSelected];

  if keyJustPressed("UI_UP") or keyJustPressed("UI_DOWN") then
   optionChoose((keyJustPressed('UI_UP') and -1 or 1));
  end

  if daSelected == "skiptime" then
   if keyJustPressed('UI_LEFT') or keyJustPressed('UI_RIGHT') then
    menuPlaySound("scrollMenu", 0.4);
    curTime = curTime + (keyJustPressed('UI_LEFT') and -1000 or 1000);
    holdTime = 0;
   end

   if keyPressed('UI_LEFT') or keyPressed('UI_RIGHT') then
    holdTime = holdTime + elapsed;
    if holdTime > 0.5 then
     curTime = curTime + 45000 * elapsed * (keyPressed('UI_LEFT') and -1 or 1);
    end
    if curTime >= getPropertyFromClass('flixel.FlxG', 'sound.music.length') then 
     curTime = curTime - getPropertyFromClass('flixel.FlxG', 'sound.music.length');
    elseif curTime < 0 then
     curTime = curTime + getPropertyFromClass('flixel.FlxG', 'sound.music.length');
    end
    updateSkipTimeText();
   end
  end

  if keyJustPressed("ACCEPT") and (cantUnPause <= 0 or not getPropertyFromClass("backend.Controls", "instance.controllerMode")) then
   if daSelected == "resume" then
    closeCustomSubstate();
   elseif daSelected == "restart" then
    restartSong();
   elseif daSelected == "botplay" then
    runHaxeCode([[
     game.cpuControlled = !game.cpuControlled;
     PlayState.changedDifficulty = true;
     game.botplayTxt.visible = game.cpuControlled;
     game.botplayTxt.alpha = 1;
     game.botplaySine = 0;
    ]]);
    setProperty("botplayText.visible", getPropertyFromClass("states.PlayState", "instance.cpuControlled"));
    menuPlaySound((getProperty("botplayTxt.visible") and "confirmMenu" or "cancelMenu"));
   elseif daSelected == "practice" then
    runHaxeCode([[
     game.practiceMode = !game.practiceMode;
     PlayState.changedDifficulty = true;
    ]]);
    setProperty("practiceText.visible", getPropertyFromClass("states.PlayState", "instance.practiceMode"));
    menuPlaySound((getProperty("practiceText.visible") and "confirmMenu" or "cancelMenu"));
   elseif daSelected == "exit" then
    runHaxeCode([[
     PlayState.deathCounter = 0;
     PlayState.seenCutscene = false;
    ]]);
    exitSong();
   elseif daSelected == "endsong" then
    closeCustomSubstate()
    runHaxeCode([[
     PlayState.instance.notes.clear();
     PlayState.instance.unspawnNotes = [];
     PlayState.instance.finishSong(true);
    ]]);
   elseif daSelected == "skiptime" then
    if curTime < getPropertyFromClass('backend.Conductor', 'songPosition') then
     runHaxeCode([[
      PlayState.startOnTime = ]] .. curTime .. [[;
     ]]);
     restartSong();
    else
     if curTime ~= getPropertyFromClass('backend.Conductor', 'songPosition') then
      runHaxeCode([[
       PlayState.instance.clearNotesBefore(]] .. curTime .. [[);
       PlayState.instance.setSongTime(]] .. curTime .. [[);
      ]]);
     end
     closeCustomSubstate();
    end
   else
    closeCustomSubstate();
    return;
   end
  end

  if keyboardJustPressed(optionKey) then
   runHaxeCode([[
    import options.OptionsState;
    import backend.MusicBeatState;

    game.paused = true;
    game.vocals.volume = 0;
    MusicBeatState.switchState(new OptionsState());
    OptionsState.onPlayState = true;
    if (ClientPrefs.data.pauseMusic != 'None') {
     FlxG.sound.playMusic(Paths.music("]] .. getPauseSong() .. [["), ]] .. getPauseVolume() .. [[);
     FlxTween.tween(FlxG.sound.music, {volume: 1}, 0.8);
     FlxG.sound.music.time = ]] .. getPauseTime() .. [[;
    }
   ]]);
  end
 end
end

function onCustomSubstateDestroy(name)
 if name == "h024PauseSubstate" then
  for i = 1, #menuSprites do
   removeLuaSprite(menuSprites[i], true);
   cancelTween(menuSprites[i]);
  end
  removeLuaText("skipTimeText", true);
  removeLuaText("optionMenuTxt", true);
  removeLuaText("levelInfo", true);
  removeLuaText("levelDifficulty", true);
  removeLuaText("blueballedTxt", true);
  removeLuaText("practiceText", true);
  removeLuaText("chartingText", true);
  menuPlaySound("cancelMenu");
 end
end

function optionChoose(choose)
 if choose == nil then choose = 0; end
 curSelected = curSelected + choose;

 menuPlaySound("scrollMenu", 0.4);

 if curSelected >= #menuItems + 1 then
  curSelected = 1;
 elseif curSelected <= 0 then
  curSelected = #menuItems;
 end
 for i = 1, #menuItems do
  if menuItems[i] == "skiptime" then
   curTime = math.max(0, getPropertyFromClass('backend.Conductor', 'songPosition'));
   updateSkipTimeText();
  end
 end
end

function optionSelected(option)
 for _, sprites in ipairs(menuItems) do
  setProperty(sprites .. ".alpha", 0.8);
 end
  setProperty(option .. ".alpha", 1.0);
end

function regenMenu()
 for i = 1, #menuItems do
  if menuItems[i] == "skiptime" then
   makeLuaText("skipTimeText", "");
   setTextSize("skipTimeText", 64);
   setCamMenu("skipTimeText");
   runHaxeCode("CustomSubstate.instance.add(game.getLuaObject('skipTimeText'));");

   updateSkipTextStuff();
   updateSkipTimeText();
  end
 end

 curSelected = 1;
 optionChoose();
end

function tweenMenu()
 startTween("overlay", "overlay", {alpha = 1}, 0.35, {ease = "quartOut"});
 startTween("cubes1", "cubes1", {x = 0}, 0.25, {ease = "quartOut"});
 startTween("cubes2", "cubes2", {x = 0}, 0.3, {ease = "quartOut"});
 startTween("sidebar", "sidebar", {x = 0}, 0.35, {ease = "quartOut"});
 for i = 1, #menuItems do startTween(menuItems[i], menuItems[i], {x = 0}, 0.35, {ease = "quartOut", startDelay = (i - 1) * 3 / 100}); end
end

function spritePosition(tag, pos)
 if tag == nil then return; end
 if pos == "left" then
  setProperty(tag .. ".x", -getProperty(tag .. ".width"));
 elseif pos == "right" then
  setProperty(tag .. ".x", getProperty(tag .. ".width"));
 else
  return;
 end
end

function updateSkipTextStuff()
 if tableContains(menuSprites, "skiptime") then
  setProperty("skipTimeText.x", getProperty("skiptime.x") + 600);
  setProperty("skipTimeText.y", getProperty("skiptime.y") + 300);
  setProperty("skipTimeText.visible", (getProperty("skiptime.alpha") >= 1));
 end
end

function updateSkipTimeText()
 runHaxeCode("game.getLuaObject('skipTimeText').text = FlxStringUtil.formatTime(Math.max(0, Math.floor(" .. curTime .. " / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);");
end

function menuPlaySound(sound, volume)
 if volume == nil then volume = 1.0; end
 stopSound(sound);
 playSound(sound, volume, sound);
end

function tableInsert(tbl, pos, value)
 if not tableContains(tbl, value) then
  table.insert(tbl, pos, value);
 end
end

function tableContains(tbl, value)
 for _, v in ipairs(tbl) do
  if v == value then
   return true;
  end
 end
 return false;
end