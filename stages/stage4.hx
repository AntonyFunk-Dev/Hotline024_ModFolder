import psychlua.LuaUtils;

function onCreate() {
	var bg:FlxSprite = new FlxSprite(-1830, -1180).loadGraphic(Paths.image(getVar('stageDir') + '/bg'));
	bg.antialiasing = ClientPrefs.data.antialiasing;
	bg.scrollFactor.set(0.75, 0.75);
	bg.scale.set(1.8, 1.8);
	bg.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), bg);

	var buildings:FlxSprite = new FlxSprite(-1990, -1280).loadGraphic(Paths.image(getVar('stageDir') + '/buildings'));
	buildings.antialiasing = ClientPrefs.data.antialiasing;
	buildings.scrollFactor.set(0.9, 0.9);
	buildings.scale.set(1.8, 1.8);
	buildings.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), buildings);

	if (!ClientPrefs.data.lowQuality) {
		var buildings2:FlxSprite = new FlxSprite(-2030, -1280).loadGraphic(Paths.image(getVar('stageDir') + '/buildings2'));
		buildings2.antialiasing = ClientPrefs.data.antialiasing;
		buildings2.scrollFactor.set(0.95, 0.95);
		buildings2.scale.set(1.8, 1.8);
		buildings2.updateHitbox();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), buildings2);
	}

	var ground:FlxSprite = new FlxSprite(-2070, -1280).loadGraphic(Paths.image(getVar('stageDir') + '/ground'));
	ground.antialiasing = ClientPrefs.data.antialiasing;
	ground.scale.set(1.8, 1.8);
	ground.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), ground);

	if (!ClientPrefs.data.lowQuality) {
		if (ClientPrefs.data.shaders) {
			var overlay3:FlxSprite = new FlxSprite(-2070, -1250).loadGraphic(Paths.image(getVar('stageDir') + '/overlay3'));
			overlay3.antialiasing = ClientPrefs.data.antialiasing;
			overlay3.blend = LuaUtils.blendModeFromString('multiply');
			overlay3.scale.set(1.8, 1.8);
			overlay3.updateHitbox();
			insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), overlay3);
		}

		var overlay2:FlxSprite = new FlxSprite(-2200, -1320).loadGraphic(Paths.image(getVar('stageDir') + '/overlay2'));
		overlay2.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) overlay2.blend = LuaUtils.blendModeFromString('add');
		overlay2.scrollFactor.set(1.1, 1.1);
		overlay2.scale.set(1.8, 1.8);
		overlay2.updateHitbox();
		add(overlay2);

		var overlay1:FlxSprite = new FlxSprite(-2200, -1320).loadGraphic(Paths.image(getVar('stageDir') + '/overlay1'));
		overlay1.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) overlay1.blend = LuaUtils.blendModeFromString('add');
		overlay1.scrollFactor.set(1.1, 1.1);
		overlay1.scale.set(1.8, 1.8);
		overlay1.updateHitbox();
		add(overlay1);

		var bushes:FlxSprite = new FlxSprite(-2190, -1300).loadGraphic(Paths.image(getVar('stageDir') + '/bushes'));
		bushes.antialiasing = ClientPrefs.data.antialiasing;
		bushes.scrollFactor.set(1.3, 1.3);
		bushes.scale.set(1.8, 1.8);
		bushes.updateHitbox();
		add(bushes);
	}

	return;
}