game.startHScriptsNamed('scripts/config/NikkuSelectMenu.hx');

function onCreatePost() {
	game.boyfriend.kill();
	game.dad.kill();
	game.gf.kill();

	game.camGame.kill();
	game.camHUD.kill();
}

function onStartCountdown() return Function_Stop;