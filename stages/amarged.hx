import psychlua.LuaUtils;

function onCreate() {
	var background:FlxSprite = new FlxSprite(-260, -100).loadGraphic(Paths.image(getVar('stageDir') + '/background'));
	background.antialiasing = ClientPrefs.data.antialiasing;
	background.scrollFactor.set(0.3, 0.3);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), background);

	if (!ClientPrefs.data.lowQuality) {
		var build2:FlxSprite = new FlxSprite(-150, -70).loadGraphic(Paths.image(getVar('stageDir') + '/build2'));
		build2.antialiasing = ClientPrefs.data.antialiasing;
		build2.scrollFactor.set(0.5, 0.5);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), build2);
	}

	var water:FlxSprite = new FlxSprite(-160, -50).loadGraphic(Paths.image(getVar('stageDir') + '/water'));
	water.antialiasing = ClientPrefs.data.antialiasing;
	water.scrollFactor.set(0.6, 0.6);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), water);

	var bars:FlxSprite = new FlxSprite().loadGraphic(Paths.image(getVar('stageDir') + '/bars'));
	bars.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), bars);

	if (!ClientPrefs.data.lowQuality) {
		var rocks:FlxSprite = new FlxSprite(60, 40).loadGraphic(Paths.image(getVar('stageDir') + '/rocks'));
		rocks.antialiasing = ClientPrefs.data.antialiasing;
		rocks.scrollFactor.set(1.2, 1.2);
		add(rocks);
	}

	return;
}