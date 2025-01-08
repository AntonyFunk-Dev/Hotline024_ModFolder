import psychlua.LuaUtils;

if (!ClientPrefs.data.lowQuality) game.startHScriptsNamed('stages/display/Rocks.hx');

function onCreate() {
	var bg:FlxSprite = new FlxSprite(-1150, -350).loadGraphic(Paths.image(getVar('stageDir') + '/bg'));
	bg.antialiasing = ClientPrefs.data.antialiasing;
	bg.scrollFactor.set();
	bg.scale.set(1.8, 1.8);
	bg.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), bg);

	var SUM_2:FlxSprite = new FlxSprite(550, 150).loadGraphic(Paths.image(getVar('stageDir') + '/SUM_2'));
	SUM_2.antialiasing = ClientPrefs.data.antialiasing;
	if (ClientPrefs.data.shaders) SUM_2.blend = LuaUtils.blendModeFromString('add');
	SUM_2.scrollFactor.set(0.02, 0.02);
	SUM_2.velocity.set(-1.5, -0.75);
	SUM_2.scale.set(1.8, 1.8);
	SUM_2.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), SUM_2);

	if (!ClientPrefs.data.lowQuality) {
		var SUM:FlxSprite = new FlxSprite(950, -580).loadGraphic(Paths.image(getVar('stageDir') + '/SUM'));
		SUM.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) SUM.blend = LuaUtils.blendModeFromString('add');
		SUM.scrollFactor.set(0.1, 0.1);
		SUM.velocity.set(-5, -2.5);
		SUM.scale.set(1.5, 1.5);
		SUM.updateHitbox();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), SUM);

		var plaRed:FlxSprite = new FlxSprite(2100, -720).loadGraphic(Paths.image(getVar('stageDir') + '/PlaRed'));
		plaRed.antialiasing = ClientPrefs.data.antialiasing;
		plaRed.scrollFactor.set(0.15, 0.15);
		plaRed.velocity.set(-6, -3);
		plaRed.scale.set(1.5, 1.5);
		plaRed.updateHitbox();
		plaRed.angle = -15;
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), plaRed);

		var plaBlue:FlxSprite = new FlxSprite(850, 850).loadGraphic(Paths.image(getVar('stageDir') + '/PlaBlue'));
		plaBlue.antialiasing = ClientPrefs.data.antialiasing;
		plaBlue.scrollFactor.set(0.12, 0.12);
		plaBlue.velocity.set(-10.5, -5.25);
		plaBlue.scale.set(1.8, 1.8);
		plaBlue.updateHitbox();
		plaBlue.angle = 15;
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), plaBlue);
	}

	return;
}