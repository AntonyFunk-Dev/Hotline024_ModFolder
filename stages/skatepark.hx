import psychlua.LuaUtils;

function onCreate() {
	var sky:FlxSprite = new FlxSprite(-460, -240).loadGraphic(Paths.image(getVar('stageDir') + '/sky'));
	sky.antialiasing = ClientPrefs.data.antialiasing;
	sky.scrollFactor.set(0.25, 0.25);
	sky.scale.set(1.1, 1.1);
	sky.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), sky);

	if (!ClientPrefs.data.lowQuality) {
		var buildings:FlxSprite = new FlxSprite(-200, -120).loadGraphic(Paths.image(getVar('stageDir') + '/buildings'));
		buildings.antialiasing = ClientPrefs.data.antialiasing;
		buildings.scrollFactor.set(0.65, 0.65);
		buildings.scale.set(1.1, 1.1);
		buildings.updateHitbox();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), buildings);
	}

	var trees:FlxSprite = new FlxSprite(-180, 0).loadGraphic(Paths.image(getVar('stageDir') + '/trees'));
	trees.antialiasing = ClientPrefs.data.antialiasing;
	trees.scrollFactor.set(0.9, 0.9);
	trees.scale.set(1.1, 1.1);
	trees.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), trees);

	var floor:FlxSprite = new FlxSprite().loadGraphic(Paths.image(getVar('stageDir') + '/floor'));
	floor.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), floor);

	if (!ClientPrefs.data.lowQuality) {
		var light:FlxSprite = new FlxSprite(0, 120).loadGraphic(Paths.image(getVar('stageDir') + '/light'));
		light.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) light.blend = LuaUtils.blendModeFromString('add');
		light.scrollFactor.set(1.1, 1.1);
		light.scale.set(1.1, 1.1);
		light.updateHitbox();
		add(light);

		var bushes:FlxSprite = new FlxSprite(-150, 70).loadGraphic(Paths.image(getVar('stageDir') + '/bushes'));
		bushes.antialiasing = ClientPrefs.data.antialiasing;
		bushes.scrollFactor.set(1.3, 1.3);
		bushes.scale.set(1.2, 1.2);
		bushes.updateHitbox();
		add(bushes);
	}

	return;
}