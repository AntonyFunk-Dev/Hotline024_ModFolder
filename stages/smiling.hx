import psychlua.LuaUtils;

function onCreate() {
	var bg:FlxSprite = new FlxSprite(-260, -220).loadGraphic(Paths.image(getVar('stageDir') + '/bg'));
	bg.antialiasing = ClientPrefs.data.antialiasing;
	bg.scrollFactor.set(0.5, 0.5);
	bg.scale.set(0.6, 0.6);
	bg.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), bg);

	return;
}