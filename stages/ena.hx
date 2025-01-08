import psychlua.LuaUtils;

function onCreate() {
	var ENA_1:FlxSprite = new FlxSprite(-350, -150).loadGraphic(Paths.image(getVar('stageDir') + '/ENA_1'));
	ENA_1.antialiasing = ClientPrefs.data.antialiasing;
	ENA_1.scrollFactor.set(0.2, 0.2);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), ENA_1);

	var ENA_2:FlxSprite = new FlxSprite(-240, -60).loadGraphic(Paths.image(getVar('stageDir') + '/ENA_2'));
	ENA_2.antialiasing = ClientPrefs.data.antialiasing;
	ENA_2.scrollFactor.set(0.6, 0.6);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), ENA_2);

	var ENA_3:FlxSprite = new FlxSprite(-225, -60).loadGraphic(Paths.image(getVar('stageDir') + '/ENA_3'));
	ENA_3.antialiasing = ClientPrefs.data.antialiasing;
	ENA_3.scrollFactor.set(0.65, 0.65);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), ENA_3);

	if (!ClientPrefs.data.lowQuality) {
		var OERLAY_4:FlxSprite = new FlxSprite(0, 50).loadGraphic(Paths.image(getVar('stageDir') + '/OERLAY_4'));
		OERLAY_4.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) OERLAY_4.blend = LuaUtils.blendModeFromString('add');
		add(OERLAY_4);
		
		var ENA_5:FlxSprite = new FlxSprite(100, 100).loadGraphic(Paths.image(getVar('stageDir') + '/ENA_5'));
		ENA_5.antialiasing = ClientPrefs.data.antialiasing;
		ENA_5.scrollFactor.set(1.3, 1.3);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), ENA_5);
	}

	return;
}