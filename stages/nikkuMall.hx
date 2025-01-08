import psychlua.LuaUtils;

function onCreate() {
	var back:FlxSprite = new FlxSprite(-1030, -650).loadGraphic(Paths.image(getVar('stageDir') + '/back'));
	back.antialiasing = ClientPrefs.data.antialiasing;
	back.scrollFactor.set(0.95, 0.95);
	back.scale.set(2.5, 2.5);
	back.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), back);

	var front:FlxSprite = new FlxSprite(-1120, -680).loadGraphic(Paths.image(getVar('stageDir') + '/front'));
	front.antialiasing = ClientPrefs.data.antialiasing;
	front.scale.set(2.6, 2.6);
	front.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), front);

	if (!ClientPrefs.data.lowQuality) {
		var light:FlxSprite = new FlxSprite(-1120, -600).loadGraphic(Paths.image(getVar('stageDir') + '/light'));
		light.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) light.blend = LuaUtils.blendModeFromString('add');
		light.scrollFactor.set(1.1, 1.1);
		light.scale.set(2.6, 2.6);
		light.updateHitbox();
		add(light);

		var cables:FlxSprite = new FlxSprite(-1120, -150).loadGraphic(Paths.image(getVar('stageDir') + '/cables'));
		cables.antialiasing = ClientPrefs.data.antialiasing;
		cables.scrollFactor.set(1.2, 1.2);
		cables.scale.set(2.5, 2.5);
		cables.updateHitbox();
		add(cables);

		var plants:FlxSprite = new FlxSprite(-850, -250).loadGraphic(Paths.image(getVar('stageDir') + '/plants'));
		plants.antialiasing = ClientPrefs.data.antialiasing;
		plants.scrollFactor.set(1.4, 1.4);
		plants.scale.set(2.4, 2.4);
		plants.updateHitbox();
		add(plants);
	}

	return;
}