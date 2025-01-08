luaDebugMode = true;

local oneClick = true;

local isSubstate = true;
local char = {"nikku", "nikku-24", "nikku-jojo", "nikku-classic"};
local charSkins = {"nikku", "nikku2", "jojo", "classic"};
local curSelected = 1;


function onCreate()
	for i = 1, #char do addCharacterToList(char[i], "dad"); end
	for i = 1, #charSkins do
		precacheImage("skins/" .. charSkins[i]);
		precacheImage("skins/" .. charSkins[i] .. "Shadow");
	end

	if getPropertyFromClass("states.PlayState", "SONG.player2") == getDataFromSave('charData', 'char') then
		setPropertyFromClass("states.PlayState", "SONG.player2", getDataFromSave('charData', 'char'));
	end

	initSaveData("charData");
	setDataFromSave("charData", "char", char[1]);
	flushSaveData('charData');

	if not seenCutscene then
		runTimer('openSelectSubstate', 0.00001);
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'openSelectSubstate' then
		openCustomSubstate("h024CharSelectSubstate", true);
	end
end

function onCustomSubstateCreate(name)
 if name == "h024CharSelectSubstate" then
	runHaxeCode([[
	 FlxTween.globalManager.forEach(function(twn:FlxTween) twn.active = false);
	 FlxTimer.globalManager.forEach(function(tmr:FlxTimer) tmr.active = false);
	]]);

	playMusic("nightlight", 1, true);

	curSelected = 1;
	optionChoose();

	makeLuaSprite("bgMenu", "skins/bg");
	setObjectCamera("bgMenu", 'camOther');
	insertToCustomSubstate("bgMenu");

	makeLuaSprite("charSelectShadow", "skins/" .. charSkins[curSelected] .. "Shadow");
	setObjectCamera("charSelectShadow", 'camOther');
	setProperty("charSelectShadow.offset.x", -5);
	insertToCustomSubstate("charSelectShadow");

	makeLuaSprite("charSelect", "skins/" .. charSkins[curSelected]);
	setObjectCamera("charSelect", 'camOther');
	insertToCustomSubstate("charSelect");

	makeLuaSprite("textMenu", "skins/text");
	setObjectCamera("textMenu", 'camOther');
	insertToCustomSubstate("textMenu");

	makeLuaSprite("trianglesMenu", "skins/triangles");
	setObjectCamera("trianglesMenu", 'camOther');
	insertToCustomSubstate("trianglesMenu");

	makeLuaSprite("barsMenu", "skins/bars");
	setObjectCamera("barsMenu", 'camOther');
	insertToCustomSubstate("barsMenu");
 end
end

function onCustomSubstateUpdate(name, elapsed)
 if name == "h024CharSelectSubstate" then
	if keyJustPressed("UI_LEFT") or keyJustPressed("UI_RIGHT") then
	 optionChoose((keyJustPressed('UI_LEFT') and -1 or 1));
	 transSprite((keyJustPressed('UI_LEFT') and 40 or -40), (keyJustPressed('UI_LEFT') and 5 or -5));
	end

	if keyJustPressed("ACCEPT") and oneClick then
	 triggerEvent("Change Character", "dad", char[curSelected]);
	 setPropertyFromClass("states.PlayState", "SONG.player2", char[curSelected]);
	 setDataFromSave("charData", "char", char[curSelected]);
	 flushSaveData('charData');
	 menuPlaySound("confirmMenu");
	 oneClick = false;
	end
 end
end

function transSprite(pos, posShadow)
 setProperty("charSelectShadow.alpha", 0.65);
 setProperty("charSelect.alpha", 0.65);
 loadGraphic("charSelectShadow", "skins/" .. charSkins[curSelected] .. "Shadow");
 loadGraphic("charSelect", "skins/" .. charSkins[curSelected]);
 setProperty("charSelectShadow.x", posShadow);
 setProperty("charSelect.x", pos);
 setProperty("trianglesMenu.y", 5);
 startTween("charSelectShadow", "charSelectShadow", {x = 0, alpha = 1}, 1.75, {ease = "expoOut"});
 startTween("charSelect", "charSelect", {x = 0, alpha = 1}, 0.85, {ease = "expoOut"});
 startTween("trianglesMenu", "trianglesMenu", {y = 0}, 0.5, {ease = "expoOut"});
end

function onCustomSubstateDestroy(name, elapsed)
 if name == "h024CharSelectSubstate" then
	runHaxeCode([[
	 FlxTween.globalManager.forEach(function(twn:FlxTween) twn.active = true);
	 FlxTimer.globalManager.forEach(function(tmr:FlxTimer) tmr.active = true);
	]]);
 end
end

function optionChoose(choose)
 if choose == nil then choose = 0; end
 curSelected = curSelected + choose;

 menuPlaySound("scrollMenu");

 if curSelected >= #char + 1 then
	curSelected = 1;
 elseif curSelected <= 0 then
	curSelected = #char;
 end
end

function menuPlaySound(sound, volume)
 if volume == nil then volume = 1.0; end
 stopSound(sound);
 playSound(sound, volume, sound);
end