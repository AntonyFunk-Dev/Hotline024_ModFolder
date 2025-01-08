import psychlua.LuaUtils;

var mazin_tv:FlxSprite = null;

function onCreate() {
	var back:FlxSprite = new FlxSprite(-500, -130).loadGraphic(Paths.image(getVar('stageDir') + '/back'));
	back.antialiasing = ClientPrefs.data.antialiasing;
	back.scrollFactor.set(0.9, 0.9);
	back.scale.set(1.5, 1.5);
	back.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), back);

	var ground:FlxSprite = new FlxSprite(-500, -125).loadGraphic(Paths.image(getVar('stageDir') + '/ground'));
	ground.antialiasing = ClientPrefs.data.antialiasing;
	ground.scale.set(1.5, 1.5);
	ground.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), ground);

	if (!ClientPrefs.data.lowQuality) {
		mazin_tv = new FlxSprite(-65, 95);
		mazin_tv.frames = Paths.getSparrowAtlas(getVar('stageDir') + '/mazin_tv');
		mazin_tv.antialiasing = ClientPrefs.data.antialiasing;
		mazin_tv.animation.addByPrefix('idle', 'BG tv', 24, false);
		mazin_tv.animation.play('idle', true);
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), mazin_tv);

		var tv:FlxSprite = new FlxSprite(-650, -120).loadGraphic(Paths.image(getVar('stageDir') + '/tv'));
		tv.antialiasing = ClientPrefs.data.antialiasing;
		tv.scrollFactor.set(1.2, 1.2);
		tv.scale.set(1.5, 1.5);
		tv.updateHitbox();
		add(tv);

		var overlay:FlxSprite = new FlxSprite(-500, -150).loadGraphic(Paths.image(getVar('stageDir') + '/overlay'));
		overlay.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) overlay.blend = LuaUtils.blendModeFromString('add');
		overlay.scale.set(1.5, 1.5);
		overlay.updateHitbox();
		add(overlay);
	}

	return;
}

function onBeatHit() return if (!ClientPrefs.data.lowQuality && mazin_tv != null) mazin_tv.animation.play('idle', true);