import flixel.effects.FlxFlicker;
import flixel.text.FlxText;
import flixel.sound.FlxSound;
import backend.BaseStage;
import cutscenes.CutsceneHandler;

var skipKey:String = 'SPACE';
var skip:Bool = false;

var cutscene:CutsceneHandler;
var isCutscene:Bool = true;

var cutsceneSound:FlxSound;

var seenCutscene:Bool = false;

var objects:Array<Dynamic> = [];

var col:FlxSprite;
var bla:FlxSprite;
var skpTxt:FlxText;

function onCreate() {
	seenCutscene = PlayState.seenCutscene;

	if (!seenCutscene) {
		cutsceneSound = new FlxSound().loadEmbedded(Paths.sound('panicPhone'));
		FlxG.sound.list.add(cutsceneSound);

		col = new FlxSprite().makeGraphic(1, 1);
		col.scale.set(FlxG.width, FlxG.height);
		col.updateHitbox();
		col.screenCenter();
		col.color = FlxColor.BLACK;
		getVar('cutsceneGroup').add(col);

		skpTxt = new FlxText(0, 5, FlxG.width, 'Press \'' + skipKey + '\' to skip the intro');
		skpTxt.setFormat(Paths.font('goodbyeDespair.ttf'), 16, FlxColor.WHITE, 'center');
		skpTxt.cameras = [game.camOther];
		skpTxt.alpha = 0;
		add(skpTxt);

		bla = col.clone();
		bla.cameras = [game.camOther];
		bla.scale.set(FlxG.width, FlxG.height);
		bla.updateHitbox();
		bla.screenCenter();
		bla.color = FlxColor.BLACK;
		bla.alpha = 0;
		add(bla);

		objects.push(col);
		objects.push(skpTxt);
	}
	
	if (seenCutscene) isCutscene = false;

	return;
}

function onUpdate() {
	if (seenCutscene) return;

	if (!skip && isCutscene && keyboardJustPressed(skipKey)) {
		skip = true;

		cutscene.endTime = 0;

		onFinishTransition();
	}

	return;
}

function onStartCountdown() {
	if (isCutscene) {
		onPrepareCutscene();
		return Function_Stop;
	} else {
		return Function_Continue;
	}
}

function onPrepareCutscene() {
	Paths.sound('panicPhone');
	
	cutscene = new CutsceneHandler();

	cutscene.endTime = 12;

	setVar('updateCamera', false);

	cutscene.onStart = function() {
		game.moveCamera(true);

		FlxTween.tween(col, {alpha: 0}, 3, {ease: FlxEase.linear, startDelay: 1});

		cutsceneSound.play();

		game.boyfriend.playAnim('sit', true);
	};

	cutscene.timer(1.2, function() {
		FlxTween.tween(skpTxt, {alpha: 1}, 0.5, {ease: FlxEase.linear});

		game.dad.playAnim('1shock', true);
	});

	cutscene.timer(4.4, function() {
		game.dad.playAnim('2shock', true);
	});

	cutscene.timer(7.1, function() {
		game.boyfriend.playAnim('1shock', true);
		game.dad.playAnim('3shock', true);
	});

	cutscene.timer(7.5, function() {
		game.boyfriend.playAnim('2shock', true);
	});

	cutscene.timer(8.9, function() {
		game.boyfriend.playAnim('3shock', true);
	});

	cutscene.timer(11, function() {
		FlxTween.tween(skpTxt, {alpha: 0}, 0.5, {ease: FlxEase.linear});
	});

	cutscene.finishCallback = onFinishCutscene;
}

function onFinishCutscene() {
	isCutscene = false;

	cutsceneSound.stop();

	if (skip) return onFinishTransition();

	setVar('updateCamera', true);

	for (obj in objects) {
		obj.kill();
		obj.destroy();
	}

	bla.kill();
	bla.destroy();

	game.startCountdown();
}

function onFinishTransition() {
	FlxTween.tween(bla, {alpha: 1}, 0.35, {
		ease: FlxEase.quadInOut,
		onComplete: () -> {
			for (obj in objects) {
				obj.kill();
				obj.destroy();
			}

			setVar('updateCamera', true);

			game.startCountdown();

			FlxTween.tween(bla, {alpha: 0}, 0.35, {
				ease: FlxEase.quadInOut,
				startDelay: 0.3,
				onComplete: () -> {
					bla.kill();
					bla.destroy();
				}
			});
		}
	});
}