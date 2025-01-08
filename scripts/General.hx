import flixel.text.FlxText;
import flixel.group.FlxTypedSpriteGroup;
import options.OptionsState;
import backend.CoolUtil;
import backend.Mods;

var camCutscene:FlxCamera = new FlxCamera();
camCutscene.bgColor = 0x00;

var cutsceneGroup:FlxTypedSpriteGroup<Dynamic> = new FlxTypedSpriteGroup();

var pauseMusic:String = ClientPrefs.data.pauseMusic;

var charConfig:Bool = false;

var songCreditBG:FlxSprite;
var songCreditTxt:FlxText;

game.introSoundsSuffix = '-h024';

OptionsState.onPlayState = false;

setVar('camCutscene', camCutscene);
setVar('cutsceneGroup', cutsceneGroup);

setVar('ratingDecPercent', 0);
setVar('ratingStr', '');

setVar('stageDir', 'stages/' + PlayState.curStage);
setVar('stageConfigJson', 'stages/config/' + PlayState.curStage + '.json');

setVar('currentModDirectory', Mods.currentModDirectory);

setVar('FlxTextBorderStyle', Type.resolveEnum('flixel.text.FlxTextBorderStyle'));

if (Paths.fileExists(getVar('stageConfigJson')))
game.startHScriptsNamed('scripts/config/StageConfig.hx');

if (getModSetting('h024ScoreCounter', getVar('currentModDirectory')))
game.startHScriptsNamed('scripts/config/ScoreCounter.hx');

if (getModSetting('h024PauseMenu', getVar('currentModDirectory')))
game.startHScriptsNamed('scripts/config/PauseSubstate.hx');

if (getModSetting('h024GameOver', getVar('currentModDirectory')))
game.startHScriptsNamed('scripts/config/GameOver.hx');

if (getModSetting('h024PauseMusic', getVar('currentModDirectory')) != 'ClientPrefs' && ClientPrefs.data.pauseMusic != 'None')
ClientPrefs.data.pauseMusic = getModSetting('h024PauseMusic', getVar('currentModDirectory'));

if (PlayState.SONG.player2 == 'nikku') {
	if (getModSetting('h024NikkuStyleMenu', getVar('currentModDirectory'))) {
		if (!PlayState.seenCutscene) {
			game.startHScriptsNamed('scripts/config/NikkuStyleSubstate.hx');
		} else {
			if (FlxG.save.data.nikkuStyle != null && !PlayState.chartingMode) {
				PlayState.SONG.player2 = FlxG.save.data.nikkuStyle;
			}
		}	
	} else {
		if (!PlayState.chartingMode) PlayState.SONG.player2 = Paths.formatToSongPath(getModSetting('h024NikkuStyle', getVar('currentModDirectory')));
	}

	Paths.clearUnusedMemory();
}

for (char in [PlayState.SONG.player1, PlayState.SONG.player2, PlayState.SONG.gfVersion]) {
	if (Paths.fileExists('characters/config/' + char + '.json')) charConfig = true;
}

if (charConfig) game.startHScriptsNamed('scripts/config/CharConfig.hx');

function onCreate() {
	game.setOnHScript('getScoreTxt', getScoreTxt);
	game.setOnHScript('getChar', getChar);
	game.setOnHScript('isJsonEmpty', isJsonEmpty);
	game.setOnHScript('triggerSelectSound', triggerSelectSound);

	game.setOnScripts('mustHitSection', PlayState.SONG.notes[curSection].mustHitSection);
	game.setOnScripts('altAnim', PlayState.SONG.notes[curSection].altAnim);
	game.setOnScripts('gfSection', PlayState.SONG.notes[curSection].gfSection);

	var upperBar:FlxSprite = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
	upperBar.cameras = [game.camHUD];
	upperBar.scrollFactor.set();
	upperBar.scale.set(FlxG.width * 1.5, FlxG.height / 1.5);
	upperBar.updateHitbox();
	upperBar.screenCenter(0x01);
	add(upperBar);
	upperBar.y -= upperBar.height - 70;

	var lowerBar:FlxSprite = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
	lowerBar.cameras = [game.camHUD];
	lowerBar.scrollFactor.set();
	lowerBar.scale.set(FlxG.width * 1.5, FlxG.height / 1.5);
	lowerBar.updateHitbox();
	lowerBar.screenCenter(0x01);
	add(lowerBar);
	lowerBar.y += lowerBar.height + 170;

	songCreditBG = new FlxSprite(0, 200).loadGraphic(Paths.image('ui/songSlide/bartext'));
	songCreditBG.antialiasing = ClientPrefs.data.antialiasing;
	songCreditBG.cameras = [game.camOther];
	songCreditBG.scrollFactor.set();
	add(songCreditBG);
	songCreditBG.alpha = 0.5;

	songCreditTxt = new FlxText(0, 0, 0, PlayState.SONG.song);
	songCreditTxt.setFormat(Paths.font('cocoSharp.ttf'), 40, FlxColor.WHITE, 'left');
	songCreditTxt.antialiasing = ClientPrefs.data.antialiasing;
	songCreditTxt.cameras = [game.camOther];
	songCreditTxt.scrollFactor.set();
	add(songCreditTxt);

	songCreditBG.x -= songCreditBG.width;
	songCreditTxt.x -= songCreditTxt.width;
	songCreditBG.scale.y = songCreditBG.scale.y / (songCreditBG.height / songCreditTxt.height) + 0.25;

	songCreditTxt.y = songCreditBG.y + (songCreditBG.height - songCreditTxt.height) / 2;

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
		case Countdown.THREE:
			var startCredit:FlxTimer = new FlxTimer().start(Conductor.crochet / 1000, () -> {
				FlxTween.tween(songCreditBG, {x: (-songCreditBG.width + songCreditTxt.width) + 75}, (Conductor.crochet / 1000) * 2, {
					ease: FlxEase.quartOut,
					onUpdate: () -> {songCreditTxt.x = songCreditBG.x + (songCreditBG.width - songCreditTxt.width) - 60;},
					onComplete: () -> {
						var finishCredit:FlxTimer = new FlxTimer().start((Conductor.crochet / 1000) * 8 + 0.5, () -> {
							FlxTween.tween(songCreditBG, {x: -songCreditBG.width}, (Conductor.crochet / 1000) * 2, {
								ease: FlxEase.quartIn,
								onUpdate: () -> {songCreditTxt.x = songCreditBG.x + (songCreditBG.width - songCreditTxt.width) - 60;}
							});
						});
					}
				});
			});

		case Countdown.TWO:
		game.countdownReady.cameras = [game.camOther];

		case Countdown.ONE:
		game.countdownSet.cameras = [game.camOther];

		case Countdown.GO:
		game.countdownGo.cameras = [game.camOther];
	}

	return;
}

function onPause() {
	if (game.inCutscene && !getModSetting('h024PauseMenu', getVar('currentModDirectory'))) return Function_Stop;

	if (!game.inCutscene) {
		FlxTween.globalManager.forEach(function(twn:FlxTween) twn.active = false);
		FlxTimer.globalManager.forEach(function(tmr:FlxTimer) tmr.active = false);
	}

	return;
}

function onResume() {
	FlxTween.globalManager.forEach(function(twn:FlxTween) twn.active = true);
	FlxTimer.globalManager.forEach(function(tmr:FlxTimer) tmr.active = true);

	return;
}

function onDestroy() {
	if (ClientPrefs.data.pauseMusic == 'None' && OptionsState.onPlayState) FlxG.sound.music.stop(); // fix crash in options state...
	
	if (getModSetting('h024PauseMusic', getVar('currentModDirectory')) != 'ClientPrefs') ClientPrefs.data.pauseMusic = pauseMusic;

	return;
}

function getScoreTxt(score:Int) {
	return 'Score: ' + score
	+ (!game.instakillOnMiss ? ' | Misses: ' + game.songMisses : '')
	+ ' | Rating: ' + getVar('ratingStr') + '\n';
}

function getChar(?index:Int = 0) {
    switch (index) {
		case 2: return game.gf;
        case 1: return game.dad;
        default: return game.boyfriend;
    };
}

function triggerSelectSound(?isCancelled:Bool = false, ?volume:Float = 1.0, ?name:String = '') {
	return FlxG.sound.play(Paths.sound((name != null && name != '') ? name : (isCancelled ? 'cancel' : 'confirm') + 'Menu'), volume);
}

function isJsonEmpty(reflect:Dynamic) {
	return Reflect.fields(reflect).length < 1;
}