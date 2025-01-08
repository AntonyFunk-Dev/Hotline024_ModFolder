import flixel.addons.display.FlxBackdrop;
import psychlua.LuaUtils;

function onCreate() {
	var bg:FlxBackdrop = new FlxBackdrop(Paths.image(getVar('stageDir') + '/bg'), 0x01);
	bg.antialiasing = ClientPrefs.data.antialiasing;
	bg.setPosition(0, 150);
	bg.velocity.set(280, 0);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), bg);

	return;
}