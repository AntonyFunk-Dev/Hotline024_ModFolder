local charSelectMenu = getModSetting("h024NikkuSelectMenu");
local charSelect = getModSetting("h024NikkuSelect");
local pauseMenu = getModSetting("h024PauseMenu");
local comboRating = getModSetting("h024ComboRating");


if charSelectMenu and dadName == "nikku" then
 addLuaScript("scripts/h024Scripts/charSelectMenu");
 addHScript("scripts/h024Scripts/charSelectFunctions");
else
 if not seenCutscene and dadName == "nikku" then
  setPropertyFromClass("states.PlayState", "SONG.player2", charSelect);
 else
  if getPropertyFromClass("states.PlayState", "SONG.player2") == charSelect and dadName == "nikku" then
   setPropertyFromClass("states.PlayState", "SONG.player2", charSelect);
  end
 end
end

if pauseMenu then
 addLuaScript("scripts/h024Scripts/pauseMenu");
 addHScript("scripts/h024Scripts/pauseFunctions");
end

if comboRating then
 addHScript("scripts/h024Scripts/comboScore");
end