import psychlua.LuaUtils;

function onCreate() {
	var bg:FlxSprite = new FlxSprite(-950, -300).loadGraphic(Paths.image(getVar('stageDir') + '/bg'));
	bg.antialiasing = ClientPrefs.data.antialiasing;
	bg.scale.set(1.2, 1.2);
	bg.updateHitbox();
	bg.scrollFactor.set(0.2, 0.2);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), bg);

	var sun:FlxSprite = new FlxSprite(-820, -220).loadGraphic(Paths.image(getVar('stageDir') + '/sun'));
	sun.antialiasing = ClientPrefs.data.antialiasing;
	sun.scale.set(1.2, 1.2);
	sun.updateHitbox();
	sun.scrollFactor.set(0.25, 0.25);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), sun);

	if (!ClientPrefs.data.lowQuality) {
		var clouds:FlxSprite = new FlxSprite(-800, -190).loadGraphic(Paths.image(getVar('stageDir') + '/clouds'));
		clouds.antialiasing = ClientPrefs.data.antialiasing;
		clouds.scale.set(1.2, 1.2);
		clouds.updateHitbox();
		clouds.scrollFactor.set(0.3, 0.3);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), clouds);

		var castle:FlxSprite = new FlxSprite(-700, -180).loadGraphic(Paths.image(getVar('stageDir') + '/castle'));
		castle.antialiasing = ClientPrefs.data.antiaiasing;
		castle.scale.set(1.2, 1.2);
		castle.updateHitbox();
		castle.scrollFactor.set(0.42, 0.42);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), castle);
	
		var buildings:FlxSprite = new FlxSprite(-660, -190).loadGraphic(Paths.image(getVar('stageDir') + '/buildings'));
		buildings.antialiasing = ClientPrefs.data.antialiasing;
		buildings.scale.set(1.2, 1.2);
		buildings.updateHitbox();
		buildings.scrollFactor.set(0.6, 0.6);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), buildings);
	}

	var hills:FlxSprite = new FlxSprite(-560, -190).loadGraphic(Paths.image(getVar('stageDir') + '/hills'));
	hills.antialiasing = ClientPrefs.data.antialiasing;
	hills.scale.set(1.2, 1.2);
	hills.updateHitbox();
	hills.scrollFactor.set(0.8, 0.8);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), hills);

	var ground:FlxSprite = new FlxSprite(-260, -140).loadGraphic(Paths.image(getVar('stageDir') + '/ground'));
	ground.antialiasing = ClientPrefs.data.antialiasing;
	ground.scale.set(1.2, 1.2);
	ground.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), ground);

	if (!ClientPrefs.data.lowQuality) {
		var light:FlxSprite = new FlxSprite(-280, -400).loadGraphic(Paths.image(getVar('stageDir') + '/light'));
		light.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) light.blend = LuaUtils.blendModeFromString('add');
		light.scale.set(1.2, 1.2);
		light.updateHitbox();
		light.scrollFactor.set(1.1, 1.1);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), light);
		
		var cables:FlxSprite = new FlxSprite(-200, -100).loadGraphic(Paths.image(getVar('stageDir') + '/cables'));
		cables.antialiasing = ClientPrefs.data.antialiasing;
		cables.scale.set(1.2, 1.2);
		cables.updateHitbox();
		cables.scrollFactor.set(1.2, 1.2);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), cables);
	}

	return;
}