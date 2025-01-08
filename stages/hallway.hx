import psychlua.LuaUtils;

function onCreate() {
	var bg:FlxSprite = new FlxSprite(-680, -700).loadGraphic(Paths.image(getVar('stageDir') + '/bg'));
	bg.antialiasing = ClientPrefs.data.antialiasing;
	bg.scale.set(1.5, 1.5);
	bg.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), bg);

	if (!ClientPrefs.data.lowQuality) {
		var grad:FlxSprite = new FlxSprite(-665, -720).loadGraphic(Paths.image(getVar('stageDir') + '/grad'));
		grad.antialiasing = ClientPrefs.data.antialiasing;
		if (ClientPrefs.data.shaders) grad.blend = LuaUtils.blendModeFromString('add');
		grad.scrollFactor.set(1.05, 1.05);
		grad.scale.set(1.5, 1.5);
		grad.updateHitbox();
		add(grad);

		var fg:FlxSprite = new FlxSprite(-820, -760).loadGraphic(Paths.image(getVar('stageDir') + '/fg'));
		fg.antialiasing = ClientPrefs.data.antialiasing;
		fg.scrollFactor.set(1.2, 1.2);
		fg.scale.set(1.65, 1.65);
		fg.updateHitbox();
		add(fg);
	}

	return;
}