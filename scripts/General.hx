import flixel.group.FlxTypedSpriteGroup;
import options.OptionsState;
import psychlua.LuaUtils;
import backend.CoolUtil;

var camCutscene:FlxCamera = new FlxCamera();
camCutscene.bgColor = 0x00;

var cutsceneGroup:FlxTypedSpriteGroup<Dynamic> = new FlxTypedSpriteGroup();

var pauseMusic:String = ClientPrefs.data.pauseMusic;

var charConfig:Bool = false;

game.introSoundsSuffix = '-h024';

OptionsState.onPlayState = false;

setVar('camCutscene', camCutscene);
setVar('cutsceneGroup', cutsceneGroup);

setVar('ratingDecPercent', 0);
setVar('ratingStr', '');

setVar('stageDir', 'stages/' + PlayState.curStage);
setVar('stageConfigJson', 'stages/config/' + PlayState.curStage + '.json');

setVar('FlxTextBorderStyle', Type.resolveEnum('flixel.text.FlxTextBorderStyle'));

if (Paths.fileExists(getVar('stageConfigJson')))
game.startHScriptsNamed('scripts/config/StageConfig.hx');

if (getModSetting('h024ScoreCounter'))
game.startHScriptsNamed('scripts/config/ScoreCounter.hx');

if (getModSetting('h024PauseMenu'))
game.startHScriptsNamed('scripts/config/PauseSubstate.hx');

if (getModSetting('h024PauseMusic') != 'ClientPrefs' && ClientPrefs.data.pauseMusic != 'None')
ClientPrefs.data.pauseMusic = getModSetting('h024PauseMusic');

for (char in [PlayState.SONG.player1, PlayState.SONG.player2, PlayState.SONG.gfVersion]) {
	if (Paths.fileExists('characters/config/' + char + '.json')) charConfig = true;
}

if (charConfig) game.startHScriptsNamed('scripts/config/CharConfig.hx');

function onCreate() {
	var upperBar:FlxSprite = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height, FlxColor.BLACK);
	upperBar.cameras = [game.camHUD];
	upperBar.scrollFactor.set();
	upperBar.screenCenter(0x01);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), upperBar);
	upperBar.y -= upperBar.height - 70;

	var lowerBar:FlxSprite = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height, FlxColor.BLACK);
	lowerBar.cameras = [game.camHUD];
	lowerBar.scrollFactor.set();
	lowerBar.screenCenter(0x01);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), lowerBar);
	lowerBar.y += lowerBar.height - 70;

	game.setOnHScript('isJsonEmpty', isJsonEmpty);
	game.setOnHScript('getScoreTxt', getScoreTxt);
	game.setOnHScript('daRating', daRating);
	game.setOnHScript('triggerSelectSound', triggerSelectSound);

	game.setOnScripts('mustHitSection', PlayState.SONG.notes[curSection].mustHitSection);
	game.setOnScripts('altAnim', PlayState.SONG.notes[curSection].altAnim);
	game.setOnScripts('gfSection', PlayState.SONG.notes[curSection].gfSection);

	return;
}

function onCreatePost() {
	FlxG.cameras.remove(game.camGame, false);
	FlxG.cameras.add(game.camGame);

	FlxG.cameras.remove(camCutscene, false);
	FlxG.cameras.add(camCutscene, false);

	FlxG.cameras.remove(game.camHUD, false);
	FlxG.cameras.add(game.camHUD, false);

	FlxG.cameras.remove(game.camOther, false);
	FlxG.cameras.add(game.camOther, false);

	cutsceneGroup.cameras = [camCutscene];
	add(cutsceneGroup);
	
	game.timeTxt.setFormat(Paths.font('goodbyeDespair.ttf'), game.timeTxt.size);
	game.timeTxt.setBorderStyle(getVar('FlxTextBorderStyle').OUTLINE, FlxColor.BLACK, 1.4);
	game.timeTxt.antialiasing = ClientPrefs.data.antialiasing;

	game.scoreTxt.setFormat(Paths.font('goodbyeDespair.ttf'), game.scoreTxt.size += 7);
	game.scoreTxt.setBorderStyle(getVar('FlxTextBorderStyle').OUTLINE, FlxColor.BLACK, 1.4);
	game.scoreTxt.antialiasing = ClientPrefs.data.antialiasing;

	game.botplayTxt.setFormat(Paths.font('goodbyeDespair.ttf'), game.botplayTxt.size);
	game.botplayTxt.setBorderStyle(getVar('FlxTextBorderStyle').OUTLINE, FlxColor.BLACK, 1.4);
	game.botplayTxt.antialiasing = ClientPrefs.data.antialiasing;

	return;
}

function onUpdateScore() {
	if (game.totalPlayed != 0) setVar('ratingDecPercent', CoolUtil.floorDecimal(game.ratingPercent * 100, 2));
	setVar('ratingStr', game.ratingName + (game.totalPlayed != 0 ? ' (' + getVar('ratingDecPercent') + '%) - ' + game.ratingFC : ''));

	return;
}

function goodNoteHit(note) return game.camZooming = true;

function onCountdownTick(count) {
	switch(count) {
		case Countdown.TWO:
		game.countdownReady.cameras = [camCutscene];

		case Countdown.ONE:
		game.countdownSet.cameras = [camCutscene];

		case Countdown.GO:
		game.countdownGo.cameras = [camCutscene];
	}

	return;
}

function onPause() {
	FlxTween.globalManager.forEach(function(twn:FlxTween) twn.active = false);
	FlxTimer.globalManager.forEach(function(tmr:FlxTimer) tmr.active = false);

	return;
}

function onResume() {
	FlxTween.globalManager.forEach(function(twn:FlxTween) twn.active = true);
	FlxTimer.globalManager.forEach(function(tmr:FlxTimer) tmr.active = true);

	return;
}

function onDestroy() {
	if (ClientPrefs.data.pauseMusic == 'None' && OptionsState.onPlayState) FlxG.sound.music.stop(); // fix lmao
	
	if (getModSetting('h024PauseMusic') != 'ClientPrefs') ClientPrefs.data.pauseMusic = pauseMusic;

	return;
}

function getScoreTxt(score:Int) {
	return 'Score: ' + score
	+ (!game.instakillOnMiss ? ' | Misses: ' + game.songMisses : '')
	+ ' | Rating: ' + getVar('ratingStr') + '\n';
}

function daRating(name:String) {
	for (rating in game.ratingsData)
	if (rating.name == name)
	return rating;
}

function triggerSelectSound(?isCancelled:Bool = false, ?volume:Float = 1.0, ?name:String = '') {
	return FlxG.sound.play(Paths.sound((name != null && name != '') ? name : (isCancelled ? 'cancel' : 'confirm') + 'Menu'), volume);
}

function isJsonEmpty(reflect:Dynamic) {
	return Reflect.fields(reflect).length < 1;
}