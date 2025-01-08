import psychlua.LuaUtils;

function onCreate() {
	var s1:FlxSprite = new FlxSprite(-1320, -630).loadGraphic(Paths.image(getVar('stageDir') + '/s1'));
	s1.antialiasing = ClientPrefs.data.antialiasing;
	s1.scrollFactor.set(0.06, 0.06);
	s1.scale.set(1.85, 1.85);
	s1.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), s1);

	var s2:FlxSprite = new FlxSprite(-1518, -570).loadGraphic(Paths.image(getVar('stageDir') + '/s2'));
	s2.antialiasing = ClientPrefs.data.antialiasing;
	s2.scrollFactor.set(0.1, 0.1);
	s2.scale.set(1.8, 1.8);
	s2.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), s2);

	if (!ClientPrefs.data.lowQuality) {
		var s3:FlxSprite = new FlxSprite(-1380, -610).loadGraphic(Paths.image(getVar('stageDir') + '/s3'));
		s3.antialiasing = ClientPrefs.data.antialiasing;
		s3.scrollFactor.set(0.23, 0.23);
		s3.scale.set(1.75, 1.75);
		s3.updateHitbox();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), s3);

		var s4:FlxSprite = new FlxSprite(-2070, -750).loadGraphic(Paths.image(getVar('stageDir') + '/s4'));
		s4.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) s4.blend = LuaUtils.blendModeFromString('add');
		s4.scale.set(1.75, 1.75);
		s4.updateHitbox();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), s4);

		var s5:FlxSprite = new FlxSprite(-1360, -670).loadGraphic(Paths.image(getVar('stageDir') + '/s5'));
		s5.antialiasing = ClientPrefs.data.antialiasing;
		s5.scrollFactor.set(0.32, 0.32);
		s5.scale.set(1.6, 1.6);
		s5.updateHitbox();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), s5);

		var s6:FlxSprite = new FlxSprite(-1660, -790).loadGraphic(Paths.image(getVar('stageDir') + '/s6'));
		s6.antialiasing = ClientPrefs.data.antialiasing;
		s6.scrollFactor.set(0.58, 0.58);
		s6.scale.set(1.62, 1.62);
		s6.updateHitbox();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), s6);
	}

	var s7:FlxSprite = new FlxSprite(-1590, -670).loadGraphic(Paths.image(getVar('stageDir') + '/s7'));
	s7.antialiasing = ClientPrefs.data.antialiasing;
	s7.scrollFactor.set(0.65, 0.65);
	s7.scale.set(1.6, 1.6);
	s7.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), s7);

	var s8:FlxSprite = new FlxSprite(-1930, -920).loadGraphic(Paths.image(getVar('stageDir') + '/s8'));
	s8.antialiasing = ClientPrefs.data.antialiasing;
	s8.scrollFactor.set(0.82, 0.82);
	s8.scale.set(1.75, 1.75);
	s8.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), s8);

	var s9:FlxSprite = new FlxSprite(-1920, -900).loadGraphic(Paths.image(getVar('stageDir') + '/s9'));
	s9.antialiasing = ClientPrefs.data.antialiasing;
	s9.scale.set(1.62, 1.62);
	s9.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()) + 1, s9);

	if (!ClientPrefs.data.lowQuality) {
		var s10:FlxSprite = new FlxSprite(-2340, -990).loadGraphic(Paths.image(getVar('stageDir') + '/s10'));
		s10.antialiasing = ClientPrefs.data.antialiasing;
		s10.scrollFactor.set(1.1, 1.1);
		s10.scale.set(1.8, 1.8);
		s10.updateHitbox();
		add(s10);
	}

	return;
}