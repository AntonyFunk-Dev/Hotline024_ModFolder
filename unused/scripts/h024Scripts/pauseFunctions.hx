import flixel.text.FlxText;
import flixel.sound.FlxSound;

var pauseMusic:FlxSound = new FlxSound();
var songName:String = null;

function onCreate() {
	Paths.music("memories");
}

function onPause() {
	CustomSubstate.openCustomSubstate("h024PauseSubstate", true);

	return Function_Stop;
}

function onCustomSubstateCreate(name) {
	if (name == "h024PauseSubstate") {
		setPauseMusic();
	}

	return;
}

function onCustomSubstateUpdate(name, elapsed) {
	if (name == "h024PauseSubstate") {
		if (pauseMusic.volume < 0.5) pauseMusic.volume += 0.01 * elapsed;
	}

	return;
}

function onCustomSubstateDestroy(name) {
	if (name == "h024PauseSubstate") {
		pauseMusic.destroy();
	}

	return;
}

function setPauseMusic() {
	try {
		var pauseSong:String = getPauseSong();
		if (pauseSong != '') pauseMusic.loadEmbedded(Paths.music(pauseSong), true, true);
	}
	catch(e:Dynamic) {}

	pauseMusic.volume = 0;
	pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

	FlxG.sound.list.add(pauseMusic);
}

function getPauseSong() {
	var configPauseMusic = getModSetting("h024SelectPauseMusic").toLowerCase();
	if (configPauseMusic == "memories") songName = configPauseMusic;

	var formattedSongName:String = (songName != null ? Paths.formatToSongPath(songName) : '');
	var formattedPauseMusic:String = Paths.formatToSongPath(ClientPrefs.data.pauseMusic);
	if (formattedSongName == 'none' || (formattedSongName != 'none' && formattedPauseMusic == 'none')) return '';

	return (formattedSongName != '') ? formattedSongName : formattedPauseMusic;
}