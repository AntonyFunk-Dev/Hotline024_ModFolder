function onBeatHit() {
	if (curBeat == 15) {
		FlxTween.tween(FlxG.camera, {alpha: 0}, 0.1, {ease: FlxEase.linear});
		FlxTween.tween(game.camHUD, {alpha: 0}, 0.1, {ease: FlxEase.linear});
	} else if (curBeat == 16) {
		FlxG.camera.alpha = game.camHUD.alpha = 1.0;
	}
}