import flixel.effects.FlxFlicker;
import flixel.text.FlxText;
import cutscenes.CutsceneHandler;

var skipKey:String = 'accept';
var skipSongPos:Float = 10.405;

var cutscene:CutsceneHandler;

var seenCutscene:Bool = false;

var objects:Array<Dynamic> = [];

var bla:FlxSprite;
var bg:FlxSprite;
var logo:FlxSprite;
var col:FlxSprite;
var txt:FlxText;
var xtrTxt:FlxText;
var skpTxt:FlxText;

function onCreate() {
	seenCutscene = PlayState.seenCutscene;

	bg = new FlxSprite().loadGraphic(Paths.image(getVar('stageDir') + '/cutscene/bg'));
	bg.antialiasing = ClientPrefs.data.antialiasing;
	bg.scale.x = bg.scale.y = (FlxG.height / bg.height);
	bg.screenCenter();

	if (!seenCutscene) {
		logo = new FlxSprite().loadGraphic(Paths.image(getVar('stageDir') + '/cutscene/logo'));
		logo.antialiasing = ClientPrefs.data.antialiasing;
		logo.screenCenter();

		skpTxt = new FlxText(0, 0, FlxG.width, 'Press \'' + skipKey.toUpperCase() + '\' to skip the intro').setFormat(Paths.font('goodbyeDespair.ttf'), 
		16, FlxColor.WHITE, 'center', null, FlxColor.BLACK);
		skpTxt.antialiasing = ClientPrefs.data.antialiasing;
		skpTxt.borderSize = 2;
		skpTxt.alpha = 0;
	}

	col = new FlxSprite().makeGraphic(1, 1);
	col.scale.set(FlxG.width, FlxG.height);
	col.updateHitbox();
	col.screenCenter();
	col.color = FlxColor.BLACK;

	bla = col.clone();
	bla.scale.set(FlxG.width, FlxG.height);
	bla.updateHitbox();
	bla.screenCenter();
	bla.color = FlxColor.BLACK;

	txt = new FlxText(0, 0, FlxG.width, 'BEWARE OF THE MOON').setFormat(Paths.font('vcr.ttf'), 
	80, FlxColor.WHITE, 'center');
	txt.antialiasing = ClientPrefs.data.antialiasing;
	txt.y = ((FlxG.height - txt.height) / 2) - 40;
	txt.visible = false;

	xtrTxt = new FlxText(0, 0, FlxG.width, 'it\'s watching you.').setFormat(Paths.font('vcr.ttf'), 
	40, FlxColor.WHITE, 'center');
	xtrTxt.antialiasing = ClientPrefs.data.antialiasing;
	xtrTxt.y = ((FlxG.height - xtrTxt.height) / 2) + 40;
	xtrTxt.visible = false;

	return;
}

function onCreatePost() {
	objects.push(col);
	objects.push(bla);
	objects.push(bg);
	objects.push(txt);
	objects.push(xtrTxt);

	getVar('cutsceneGroup').add(bla);
	getVar('cutsceneGroup').add(bg);
	getVar('cutsceneGroup').add(txt);
	getVar('cutsceneGroup').add(xtrTxt);
	if (!seenCutscene) getVar('cutsceneGroup').add(logo);
	getVar('cutsceneGroup').add(col);
	if (!seenCutscene) getVar('cutsceneGroup').add(skpTxt);

	game.camHUD.alpha = 0;

	return;
}

var curTime:Float = (skipSongPos * 1000);
function onUpdate() {
	if (game.isDead || game.startingSong || game.endingSong) return;

	if (FlxG.sound.music != null && Conductor.songPosition < curTime) {
		if (seenCutscene || keyJustPressed(skipKey)) {
			if (!seenCutscene) cutscene.endTime = 0;

			game.clearNotesBefore(curTime);
			game.setSongTime(curTime);
		}
	}

	return;
}

function onSongStart() {
	if (!seenCutscene) game.inCutscene = true;

	game.camGame.alpha = 0;

	if (!seenCutscene) onPrepareCutscene();
	else onFinishTransition();

	return;
}

function onPrepareCutscene() {
	cutscene = new CutsceneHandler();

	cutscene.push(logo);
	cutscene.push(skpTxt);

	cutscene.endTime = skipSongPos;

	cutscene.onStart = function() {
		FlxTween.tween(skpTxt, {alpha: 1}, 0.5, {ease: FlxEase.linear});
		FlxTween.tween(col, {alpha: 0}, 4, {ease: FlxEase.linear, startDelay: 1});
	};

	cutscene.timer(4.5, function() {		 
		FlxTween.tween(col, {alpha: 1}, 1, {ease: FlxEase.quartIn});
		FlxTween.tween(logo, {y: logo.y + 500}, 1, {ease: FlxEase.quartIn});
	});

	cutscene.timer(5.55, function() {
		bg.visible = false;
		txt.visible = true;
		col.visible = false;

		FlxFlicker.flicker(txt, 0.2, 0.02);
	});

	cutscene.timer(8.14, function() {
		xtrTxt.visible = true;

		FlxFlicker.flicker(xtrTxt, 0.2, 0.02);
	});

	cutscene.timer(10.3, function() {
		bg.visible = true;
		bg.alpha = 0.25;

		FlxFlicker.flicker(bg, 0.1, 0.04, true, true, function() {
			bg.visible = false;
		});
	});

	cutscene.finishCallback = onFinishTransition;
}

function onFinishTransition() {
	if (ClientPrefs.data.flashing) col.color = FlxColor.WHITE;
	col.visible = true;

	bg.loadGraphic(Paths.image(getVar('stageDir') + '/cutscene/bgEnd'));
	bg.visible = true;
	bg.alpha = 0.35;

	txt.text = Paths.getTextFromFile('data/' 
	+ Paths.formatToSongPath(PlayState.SONG.song) 
	+ '/0.txt');
	txt.visible = true;

	xtrTxt.visible = true;

	FlxFlicker.flicker(col, 0.18, 0.05, true, true, function() {
		game.camGame.alpha = 1.0;
		game.camHUD.alpha = 1.0;

		for (obj in objects) {
			obj.kill();
			obj.destroy();
		}

		if (!seenCutscene) game.inCutscene = false;
	});
}