import psychlua.LuaUtils;

function onCreate() {
	var boo_1:FlxSprite = new FlxSprite(-210, -80).loadGraphic(Paths.image(getVar('stageDir') + '/boo_1'));
	boo_1.antialiasing = ClientPrefs.data.antialiasing;
	boo_1.scrollFactor.set(0.3, 0.3);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), boo_1);

	if (!ClientPrefs.data.lowQuality) {
		var boo_2:FlxSprite = new FlxSprite(-150, -30).loadGraphic(Paths.image(getVar('stageDir') + '/boo_2'));
		boo_2.antialiasing = ClientPrefs.data.antialiasing;
		boo_2.scrollFactor.set(0.5, 0.5);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), boo_2);
	}

	var boo_3:FlxSprite = new FlxSprite(-125, -30).loadGraphic(Paths.image(getVar('stageDir') + '/boo_3'));
	boo_3.antialiasing = ClientPrefs.data.antialiasing;
	boo_3.scrollFactor.set(0.6, 0.6);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), boo_3);

	var boo_4:FlxSprite = new FlxSprite().loadGraphic(Paths.image(getVar('stageDir') + '/boo_4'));
	boo_4.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), boo_4);

	if (!ClientPrefs.data.lowQuality) {
		var boo_5:FlxSprite = new FlxSprite(70, 180).loadGraphic(Paths.image(getVar('stageDir') + '/boo_5'));
		boo_5.antialiasing = ClientPrefs.data.antialiasing;
		boo_5.scrollFactor.set(1.3, 1.3);
		add(boo_5);

		var boo_6:FlxSprite = new FlxSprite(80, 70).loadGraphic(Paths.image(getVar('stageDir') + '/boo_6'));
		boo_6.antialiasing = ClientPrefs.data.antialiasing;
		boo_6.scrollFactor.set(1.3, 1.3);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), boo_6);
	}

	return;
}