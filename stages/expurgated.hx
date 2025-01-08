import psychlua.LuaUtils;

if (!ClientPrefs.data.lowQuality) game.startHScriptsNamed('stages/display/Particles.hx');

function onCreate() {
	var sky:FlxSprite = new FlxSprite(-1860, -1050).loadGraphic(Paths.image(getVar('stageDir') + '/sky'));
	sky.antialiasing = ClientPrefs.data.antialiasing;
	sky.scrollFactor.set(0.25, 0.25);
	sky.scale.set(2.5, 2.5);
	sky.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), sky);

	var rock2:FlxSprite = new FlxSprite(-2520, -1330).loadGraphic(Paths.image(getVar('stageDir') + '/rock2'));
	rock2.antialiasing = ClientPrefs.data.antialiasing;
	rock2.scrollFactor.set(0.78, 0.78);
	rock2.scale.set(2.5, 2.5);
	rock2.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), rock2);

	if (getVar('particlesGroup') != null) insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), getVar('particlesGroup'));

	var ground:FlxSprite = new FlxSprite(-2790, -1410).loadGraphic(Paths.image(getVar('stageDir') + '/ground'));
	ground.antialiasing = ClientPrefs.data.antialiasing;
	ground.scale.set(2.5, 2.5);
	ground.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), ground);

	if (!ClientPrefs.data.lowQuality) {
		var gradoverlay:FlxSprite = new FlxSprite(-2910, -1500).loadGraphic(Paths.image(getVar('stageDir') + '/gradoverlay'));
		gradoverlay.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) gradoverlay.blend = LuaUtils.blendModeFromString('add');
		gradoverlay.scrollFactor.set(1.1, 1.1);
		gradoverlay.scale.set(2.5, 2.5);
		gradoverlay.updateHitbox();
		add(gradoverlay);

		var signfront:FlxSprite = new FlxSprite(-3400, -1580).loadGraphic(Paths.image(getVar('stageDir') + '/signfront'));
		signfront.antialiasing = ClientPrefs.data.antialiasing;
		signfront.scrollFactor.set(1.5, 1.5);
		signfront.scale.set(2.5, 2.5);
		signfront.updateHitbox();
		add(signfront);
	}

	return;
}