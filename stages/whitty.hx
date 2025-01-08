import psychlua.LuaUtils;

function onCreate() {
	var wall:FlxSprite = new FlxSprite(-540, -400).loadGraphic(Paths.image(getVar('stageDir') + '/wall'));
	wall.antialiasing = ClientPrefs.data.antialiasing;
	wall.scrollFactor.set(0.9, 0.9);
	wall.scale.set(1.42, 1.42);
	wall.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), wall);

	var floor:FlxSprite = new FlxSprite(-540, -350).loadGraphic(Paths.image(getVar('stageDir') + '/floor'));
	floor.antialiasing = ClientPrefs.data.antialiasing;
	floor.scale.set(1.42, 1.42);
	floor.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), floor);

	if (!ClientPrefs.data.lowQuality) {
		var fg:FlxSprite = new FlxSprite(-460, -380).loadGraphic(Paths.image(getVar('stageDir') + '/fg'));
		fg.antialiasing = ClientPrefs.data.antialiasing;
		fg.scrollFactor.set(1.25, 1.25);
		fg.scale.set(1.5, 1.5);
		fg.updateHitbox();
		add(fg);
	}

	return;
}