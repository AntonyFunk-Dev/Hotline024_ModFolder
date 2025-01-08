import flixel.group.FlxTypedSpriteGroup;
import flixel.util.FlxStringUtil;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import options.OptionsState;
import backend.MusicBeatState;
import substates.PauseSubState;
import backend.Difficulty;
import psychlua.FunkinLua;

var dir:String = 'menus/pause/';

var optionsKeyboard:String = 'CONTROL';
var optionsController:String = 'X';

var menuItems:Array<String> = [];
var menuItemsOG:Array<String> = ['resume', 'restart', 'botplay', 'practice', 'exit'];

var botplayText:FlxText;
var practiceText:FlxText;

var skipTimeText:FlxText;
var skipTimeTracker:FlxSprite;

var grpItemsShit:FlxTypedSpriteGroup<Dynamic>;

var curSelected:Int = 0;
var curTime:Float = 0;

var pauseMusic:FlxSound = new FlxSound();
var songName:String = null;

function onPause() {
	if (game.inCutscene) return Function_Stop;
	
	if (!game.cpuControlled) {
		for (note in game.playerStrums)
			if(note.animation.curAnim != null && note.animation.curAnim.name != 'static') {
				note.playAnim('static');
				note.resetAnim = 0;
		}
	}

	CustomSubstate.openCustomSubstate('PauseSubState', true);

	return Function_Stop;
}

var optionTxt:FlxText;
function onCustomSubstateCreate(name) {
    if (name == 'PauseSubState') {
		curSelected = 0;

        if (PlayState.chartingMode) {
			if (menuItemsOG.indexOf('endsong') == -1) menuItemsOG.push('endsong');

            if (!PlayState.instance.startingSong) {
                if (menuItemsOG.indexOf('skiptime') == -1) menuItemsOG.push('skiptime');
            }
        }
        
        menuItems = menuItemsOG;
        
        pauseMusic = new FlxSound();

		try {
			var pauseSong:String = getPauseSong();
			if (pauseSong != null) pauseMusic.loadEmbedded(Paths.music(pauseSong), true, true);
		} catch(e:Dynamic) {}

		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

        FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
		bg.scrollFactor.set();
		bg.scale.set(FlxG.width, FlxG.height);
		bg.updateHitbox();
		bg.alpha = 0;
		CustomSubstate.instance.add(bg);
		FlxTween.tween(bg, {alpha: 0.6}, 0.3, {ease: FlxEase.quartOut});

		if (!ClientPrefs.data.lowQuality) {
			var cubes1:FlxSprite = new FlxSprite().loadGraphic(Paths.image(dir + 'cubes1'));
			cubes1.antialiasing = ClientPrefs.data.antialiasing;
			cubes1.scrollFactor.set();
			cubes1.x += cubes1.width;
			CustomSubstate.instance.add(cubes1);
			FlxTween.tween(cubes1, {x: 0}, 0.3, {ease: FlxEase.quartOut, startDelay: 0.025});

			var cubes2:FlxSprite = new FlxSprite().loadGraphic(Paths.image(dir + 'cubes2'));
			cubes2.antialiasing = ClientPrefs.data.antialiasing;
			cubes2.scrollFactor.set();
			cubes2.x -= cubes2.width;
			CustomSubstate.instance.add(cubes2);
			FlxTween.tween(cubes2, {x: 0}, 0.3, {ease: FlxEase.quartOut, startDelay: 0.05});
		}

		var sidebar:FlxSprite = new FlxSprite().loadGraphic(Paths.image(dir + 'sidebar'));
		sidebar.antialiasing = ClientPrefs.data.antialiasing;
		sidebar.scrollFactor.set();
		sidebar.x -= sidebar.width;
		CustomSubstate.instance.add(sidebar);
		FlxTween.tween(sidebar, {x: 0}, 0.3, {ease: FlxEase.quartOut, startDelay: 0.1});

		var levelInfo:FlxText = new FlxText(20, 15, 0, PlayState.SONG.song, 32);
		levelInfo.setFormat(Paths.font('goodbyeDespair.ttf'), (ClientPrefs.data.lowQuality ? 32 : 40));
		levelInfo.antialiasing = ClientPrefs.data.antialiasing;
		levelInfo.scrollFactor.set();

		var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, Difficulty.getString().toUpperCase(), 32);
		levelDifficulty.setFormat(Paths.font('goodbyeDespair.ttf'), (ClientPrefs.data.lowQuality ? 32 : 23));
		levelDifficulty.antialiasing = ClientPrefs.data.antialiasing;
		levelDifficulty.scrollFactor.set();

		var blueballedTxt:FlxText = new FlxText(20, 15 + 64, 0, 'Blueballed: ' + PlayState.deathCounter, 32);
		blueballedTxt.setFormat(Paths.font('goodbyeDespair.ttf'), 32);
		blueballedTxt.antialiasing = ClientPrefs.data.antialiasing;
		blueballedTxt.scrollFactor.set();

		if (!ClientPrefs.data.lowQuality) {
			var track:FlxSprite = new FlxSprite().loadGraphic(Paths.image(dir + 'track'));
			track.antialiasing = ClientPrefs.data.antialiasing;
			track.scrollFactor.set();
			track.x += track.width;
			CustomSubstate.instance.add(track);

			levelInfo.x = levelDifficulty.x = track.x + track.width;
			levelInfo.y = track.y + 32;
			levelDifficulty.y = levelInfo.y + 57;
			
			FlxTween.tween(track, {x: 0}, 0.3, {
				ease: FlxEase.quartOut, 
				startDelay: 0.3,
				onUpdate: () -> {
					levelInfo.x = track.x + track.width - (levelInfo.width + 20);
					levelDifficulty.x = levelInfo.x + (levelInfo.width - levelDifficulty.width) / 2;
				}
			});
	
			var blueballs:FlxSprite = new FlxSprite().loadGraphic(Paths.image(dir + 'blueballs'));
			blueballs.antialiasing = ClientPrefs.data.antialiasing;
			blueballs.scrollFactor.set();
			blueballs.x += blueballs.width;
			CustomSubstate.instance.add(blueballs);

			blueballedTxt.x = blueballs.x + blueballs.width;
			blueballedTxt.y = blueballs.y + 146;

			FlxTween.tween(blueballs, {x: 0}, 0.3, {
				ease: FlxEase.quartOut, 
				startDelay: 0.35,
				onUpdate: () -> {
					blueballedTxt.x = blueballs.x + blueballs.width - (blueballedTxt.width + 20);
				}
			});
		}

		CustomSubstate.instance.add(levelInfo);
		CustomSubstate.instance.add(levelDifficulty);
		CustomSubstate.instance.add(blueballedTxt);

		practiceText = new FlxText(20, 15 + (ClientPrefs.data.lowQuality ? 101 : 198), 0, 'PRACTICE MODE', 32);
		practiceText.setFormat(Paths.font('goodbyeDespair.ttf'), 32);
		if (!ClientPrefs.data.lowQuality) practiceText.setBorderStyle(getVar('FlxTextBorderStyle').OUTLINE, FlxColor.BLACK, 1.2);
		practiceText.antialiasing = ClientPrefs.data.antialiasing;
		practiceText.scrollFactor.set();
		practiceText.x = FlxG.width - (practiceText.width + 20);
		practiceText.visible = PlayState.instance.practiceMode;
		CustomSubstate.instance.add(practiceText);

		botplayText = new FlxText(20, 0, 0, 'BOTPLAY', 32);
		botplayText.setFormat(Paths.font('goodbyeDespair.ttf'), 32);
		botplayText.antialiasing = ClientPrefs.data.antialiasing;
		botplayText.scrollFactor.set();
		botplayText.x = FlxG.width - (botplayText.width + 20);
		botplayText.y = FlxG.height - (botplayText.height + (PlayState.chartingMode ? 55 : 20));
		botplayText.visible = PlayState.instance.cpuControlled;
		CustomSubstate.instance.add(botplayText);

		if (PlayState.chartingMode) {
			var chartingText:FlxText = new FlxText(20, 0, 0, 'CHARTING MODE', 32);
			chartingText.setFormat(Paths.font('goodbyeDespair.ttf'), 32);
			chartingText.antialiasing = ClientPrefs.data.antialiasing;
			chartingText.scrollFactor.set();
			chartingText.x = FlxG.width - (chartingText.width + 20);
			chartingText.y = FlxG.height - (chartingText.height + 20);
			CustomSubstate.instance.add(chartingText);
		}

		optionTxt = new FlxText(20, FlxG.height, 0, '', 32);
		optionTxt.setFormat(Paths.font('goodbyeDespair.ttf'), 25);
		optionTxt.setBorderStyle(getVar('FlxTextBorderStyle').OUTLINE, FlxColor.BLACK, 1.2);
		optionTxt.antialiasing = ClientPrefs.data.antialiasing;
		optionTxt.scrollFactor.set();
		CustomSubstate.instance.add(optionTxt);
		FlxTween.tween(optionTxt, {y: FlxG.height - 38}, 0.3, {ease: FlxEase.quartOut, startDelay: 0.3});

		grpItemsShit = new FlxTypedSpriteGroup();
		CustomSubstate.instance.add(grpItemsShit);

		if (ClientPrefs.data.lowQuality) {
			levelInfo.alpha = levelDifficulty.alpha = blueballedTxt.alpha = 0;

			levelInfo.x = FlxG.width - (levelInfo.width + 20);
			levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);
			blueballedTxt.x = FlxG.width - (blueballedTxt.width + 20);

			FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
			FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5});
			FlxTween.tween(blueballedTxt, {alpha: 1, y: blueballedTxt.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.7});
		}

		regenMenu();
		triggerSelectSound();
    }

	return;
}

var holdTime:Float = 0;
var cantUnpause:Float = 0.1;
function onCustomSubstateUpdate(name, elapsed) {
	if (name == 'PauseSubState') {
		cantUnpause -= elapsed;

		if (pauseMusic.volume < 0.5) pauseMusic.volume += 0.01 * elapsed;

		optionTxt.text = 'Press \'' + (controls.controllerMode ? optionsController : optionsKeyboard).toUpperCase() + '\' to access the Options Menu';
	}

	return;
}

var daSelected:String = '';
function onCustomSubstateUpdatePost(name, elapsed) {
	if (name == 'PauseSubState') {
		if (keyJustPressed('BACK')) {
			CustomSubstate.closeCustomSubstate();
			triggerSelectSound(true);
		}

		updateSkipTextStuff();

		if (keyJustPressed('UI_UP') || keyJustPressed('UI_DOWN')) {
			changeSelection((keyJustPressed('UI_UP') ? -1 : 1));
		}

		daSelected = menuItems[curSelected];
		switch(daSelected) {
			case 'skiptime':
				if (keyJustPressed('UI_LEFT') || keyJustPressed('UI_RIGHT')) {
					curTime += 1000 * (keyJustPressed('UI_LEFT') ? -1 : 1);
					holdTime = 0;

					triggerSelectSound(null, 0.4, 'scrollMenu');
				}

				if (keyPressed('UI_LEFT') || keyPressed('UI_RIGHT')) {
					holdTime += elapsed;
					if (holdTime > 0.5) curTime += 45000 * elapsed * (keyPressed('UI_LEFT') ? -1 : 1);

					if (curTime >= FlxG.sound.music.length) curTime -= FlxG.sound.music.length;
					else if (curTime < 0) curTime += FlxG.sound.music.length;

					updateSkipTimeText();
				}
		}

		if (keyJustPressed('ACCEPT') && (cantUnpause <= 0 || !Controls.instance.controllerMode)) {
			switch (daSelected) {
				case 'resume':
					CustomSubstate.closeCustomSubstate();
					triggerSelectSound(true);
				case 'restart':
					PauseSubState.restartSong();
					triggerSelectSound();
				case 'botplay':
					PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
					PlayState.changedDifficulty = true;
					PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
					PlayState.instance.botplayTxt.alpha = 1;
					PlayState.instance.botplaySine = 0;
					botplayText.visible = PlayState.instance.cpuControlled;
					triggerSelectSound(!PlayState.instance.cpuControlled);
				case 'practice':
					PlayState.instance.practiceMode = !PlayState.instance.practiceMode;
					PlayState.changedDifficulty = true;
					practiceText.visible = PlayState.instance.practiceMode;
					triggerSelectSound(!PlayState.instance.practiceMode);
				case 'skiptime':
					if (curTime < Conductor.songPosition) {
						PlayState.startOnTime = curTime;
						PauseSubState.restartSong(false); // true = crash game (yeah...)
					} else {
						if (curTime != Conductor.songPosition) {
							PlayState.instance.clearNotesBefore(curTime);
							PlayState.instance.setSongTime(curTime);
						}
						CustomSubstate.closeCustomSubstate();
					}
				case 'endsong':
					CustomSubstate.closeCustomSubstate();
					
					PlayState.instance.notes.clear();
					PlayState.instance.unspawnNotes = [];
					PlayState.instance.finishSong(true);
					triggerSelectSound(true);
				case 'exit':
					new FunkinLua('exitSong()');
					PlayState.seenCutscene = false;
					PlayState.deathCounter = 0;
					triggerSelectSound(true);
			}
		}

		if (keyboardJustPressed(optionsKeyboard) || anyGamepadJustPressed(optionsController)) {
			PlayState.instance.paused = true; // For lua
			PlayState.instance.vocals.volume = 0;

			OptionsState.onPlayState = true;

			MusicBeatState.switchState(new OptionsState());

			if (ClientPrefs.data.pauseMusic != 'None') {
				FlxG.sound.playMusic(Paths.music(getPauseSong()), pauseMusic.volume);
				FlxTween.tween(FlxG.sound.music, {volume: 1}, 0.8);
				FlxG.sound.music.time = pauseMusic.time;
			}
		}
	}

	return;
}

function onCustomSubstateDestroy(name) {
	if (name == 'PauseSubState') {
		pauseMusic.destroy();
	}

	return;
}

function regenMenu() {
	for (i in 0...menuItems.length) {
		var item:Dynamic = new FlxSprite(0, 0).loadGraphic(Paths.image(dir + menuItems[i]));
		item.antialiasing = ClientPrefs.data.antialiasing;
		item.x -= item.width;
		grpItemsShit.add(item);

		FlxTween.tween(item, {x: 0}, 0.35, {ease: FlxEase.quartOut, startDelay: (i * 3) / 100});

		if (menuItems[i] == 'skiptime') {
			skipTimeText = new FlxText(0, 0, 0, '', 64);
			skipTimeText.setFormat(Paths.font('goodbyeDespair.ttf'), 64, FlxColor.WHITE);
			skipTimeText.setBorderStyle(getVar('FlxTextBorderStyle').OUTLINE, FlxColor.BLACK);
			skipTimeText.antialiasing = ClientPrefs.data.antialiasing;
			skipTimeText.scrollFactor.set();
			skipTimeText.borderSize = 2;
			skipTimeTracker = item;
			CustomSubstate.instance.add(skipTimeText);
	
			updateSkipTextStuff();
			updateSkipTimeText();
		}
	}

	curSelected = 0;
	changeSelection();
}

function changeSelection(?change:Int = 0) {
	if (Std.int(change) != 0) triggerSelectSound(null, 0.4, 'scrollMenu');

	curSelected += Std.int(change);

	if (curSelected < 0)
		curSelected = menuItems.length - 1;
	if (curSelected >= menuItems.length)
		curSelected = 0;

	if (menuItemsOG.indexOf('skiptime') != -1) {
		curTime = Math.max(0, Conductor.songPosition);
		updateSkipTimeText();
	}

	for (item in grpItemsShit.members) {
		item.alpha = (grpItemsShit.members.indexOf(item) != curSelected ? 0.65 : 1.0);
	}
}

function getPauseSong() {
	var formattedSongName:String = (songName != null ? Paths.formatToSongPath(songName) : '');
	var formattedPauseMusic:String = Paths.formatToSongPath(ClientPrefs.data.pauseMusic);
	if (formattedSongName == 'none' || (formattedSongName != 'none' && formattedPauseMusic == 'none')) return null;

	return (formattedSongName != '') ? formattedSongName : formattedPauseMusic;
}

function updateSkipTextStuff() {
	if (menuItemsOG.indexOf('skiptime') != -1) {
		skipTimeText.x = skipTimeTracker.x + 500;
		skipTimeText.y = skipTimeTracker.y + 300;
		skipTimeText.visible = (skipTimeTracker.alpha == 1);
	}
}

function updateSkipTimeText() {
	skipTimeText.text = FlxStringUtil.formatTime(Math.max(0, Math.floor(curTime / 1000)), false) + ' / ' + FlxStringUtil.formatTime(Math.max(0, Math.floor(FlxG.sound.music.length / 1000)), false);
}