import haxe.Timer;
import psychlua.LuaUtils;

var vcr:FlxRuntimeShader = game.createRuntimeShader('VHS');

function onUpdate(elapsed) {
	vcr.setFloat('iTime', Timer.stamp());

	return;
}

function onEvent(n, v1, v2) {
	if (n == 'Astral Event') {
		if (v1 != '' && LuaUtils.cameraFromString(v1) != null) {
			switchCamShader(LuaUtils.cameraFromString(v1));
		} else {
			for (cam in [game.camGame, game.camHUD]) {
				switchCamShader(cam);
			}
		}
	}

	return;
}

function onGameOver() {
	for (cam in [game.camGame, game.camHUD, game.camOther]) {
		if (cam.filters != null && cam.filters.length > 0)
		cam.setFilters([]);
	}

	return;
}

function switchCamShader(?camera:FlxCamera = game.camHUD) {
	if (camera.filters != null && camera.filters.length > 0)
		camera.setFilters([]);
	else
		camera.setFilters([new ShaderFilter(vcr)]);

	camera.flash(FlxColor.BLACK, 5, null, true);
}