import psychlua.LuaUtils;

function onCreate() {
	if (!ClientPrefs.data.lowQuality) {
		var bg:FlxSprite = new FlxSprite(-1650, -1450).loadGraphic(Paths.image(getVar('stageDir') + '/bg'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scrollFactor.set(0.3, 0.3);
		bg.scale.set(2, 2);
		bg.updateHitbox();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), bg);
	}

	var building:FlxSprite = new FlxSprite(-2770, -1900).loadGraphic(Paths.image(getVar('stageDir') + '/building'));
	building.antialiasing = ClientPrefs.data.antialiasing;
	building.scrollFactor.set(0.9, 0.9);
	building.scale.set(2.2, 2.2);
	building.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), building);

	var floor:FlxSprite = new FlxSprite(-2905, -1970).loadGraphic(Paths.image(getVar('stageDir') + '/floor'));
	floor.antialiasing = ClientPrefs.data.antialiasing;
	floor.scale.set(2.2, 2.2);
	floor.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), floor);

	if (!ClientPrefs.data.lowQuality) {
		var grad:FlxSprite = new FlxSprite(-3250, -1950).loadGraphic(Paths.image(getVar('stageDir') + '/grad'));
		grad.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) grad.blend = LuaUtils.blendModeFromString('add');
		grad.scrollFactor.set(1.1, 1.1);
		grad.scale.set(2.3, 2.3);
		grad.updateHitbox();
		add(grad);

		var fg:FlxSprite = new FlxSprite(-3500, -2300).loadGraphic(Paths.image(getVar('stageDir') + '/fg'));
		fg.antialiasing = ClientPrefs.data.antialiasing;
		fg.scrollFactor.set(1.3, 1.3);
		fg.scale.set(2.5, 2.5);
		fg.updateHitbox();
		add(fg);
	}

	return;
}