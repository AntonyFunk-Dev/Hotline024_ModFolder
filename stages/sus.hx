import psychlua.LuaUtils;

function onCreate() {
	if (!ClientPrefs.data.lowQuality) {
		var SUS1:FlxSprite = new FlxSprite(-230, -130).loadGraphic(Paths.image(getVar('stageDir') + '/SUS1'));
		SUS1.antialiasing = ClientPrefs.data.antialiasing;
		SUS1.scrollFactor.set(0.2, 0.2);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), SUS1);
	}

	var SUS2:FlxSprite = new FlxSprite().loadGraphic(Paths.image(getVar('stageDir') + '/SUS2'));
	SUS2.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), SUS2);

	if (!ClientPrefs.data.lowQuality) {
		var SUS3:FlxSprite = new FlxSprite(30, 20).loadGraphic(Paths.image(getVar('stageDir') + '/SUS3'));
		SUS3.antialiasing = ClientPrefs.data.antialiasing;
		SUS3.scrollFactor.set(1.2, 1.2);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), SUS3);
	}

	return;
}