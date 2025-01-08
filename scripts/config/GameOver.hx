import flixel.FlxObject;
import openfl.geom.Point;
import backend.MusicBeatState;
import substates.GameOverSubstate;

var camFollow:FlxObject;
var rnd:Int = 0;

function onGameOver() {
	rnd = FlxG.random.int(1, 100);

	GameOverSubstate.characterName = (rnd != 1 ? 'death' : 'deathfucked');
	GameOverSubstate.deathSoundName = 'fnf_loss_sfx_h24';
	GameOverSubstate.loopSoundName = 'gameOver_h24';
	GameOverSubstate.endSoundName = 'gameOverEnd_h24';

	return;
}

function onGameOverStart() {
	FlxG.camera.zoom = Math.max(0.6, Math.min(FlxG.camera.zoom, 0.8));
	FlxG.camera.scroll.set();
	FlxG.camera.target = null;

	FlxG.camera.visible = true;
	FlxG.camera.alpha = 1;

	camFollow = new FlxObject(0, 0, 1, 1);
	camFollow.setPosition(GameOverSubstate.instance.boyfriend.getGraphicMidpoint().x + GameOverSubstate.instance.boyfriend.cameraPosition[0], GameOverSubstate.instance.boyfriend.getGraphicMidpoint().y + GameOverSubstate.instance.boyfriend.cameraPosition[1]);
	FlxG.camera.scroll.set((FlxG.camera.scroll.x + (FlxG.camera.width / 2)) - FlxG.camera.width / 2, (FlxG.camera.scroll.y + (FlxG.camera.height / 2)) - FlxG.camera.height / 2);
	FlxG.camera.follow(camFollow, Type.resolveEnum('flixel.FlxCameraFollowStyle').LOCKON, 0.01);
	add(camFollow);

	FlxG.camera.followLerp = 1000;
	FlxG.camera.fade(FlxColor.BLACK, 0.00001, false);

	return;
}

function onGameOverConfirm() {
	new FlxTimer().start(0.7, function(tmr:FlxTimer) {
		new FlxTimer().start(2, function(tmr:FlxTimer) {
			MusicBeatState.resetState();
		});
	}); // xd

	return;
}

function onUpdate(elapsed) {
	if (!game.isDead) return;

	if (rnd == 1) FlxG.sound.music.pitch = 0.25;

	if (GameOverSubstate.instance.boyfriend.isAnimationNull() != null && GameOverSubstate.instance.boyfriend.getAnimationName() == 'firstDeath') {
		if (GameOverSubstate.instance.boyfriend.isAnimationFinished()) FlxG.camera.fade(FlxColor.BLACK, 2, true);
	}

	return;
}