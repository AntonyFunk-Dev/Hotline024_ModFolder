import psychlua.LuaUtils;

function onCreate() {
	var BG1:FlxSprite = new FlxSprite(-1250, -820).loadGraphic(Paths.image(getVar('stageDir') + '/BG1'));
	BG1.antialiasing = ClientPrefs.data.antialiasing;
	BG1.scrollFactor.set(0.2, 0.2);
	BG1.scale.set(1.8, 1.8);
	BG1.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), BG1);

	if (!ClientPrefs.data.lowQuality) {
		var BAC2:FlxSprite = new FlxSprite(-1520, -980).loadGraphic(Paths.image(getVar('stageDir') + '/BAC2'));
		BAC2.antialiasing = ClientPrefs.data.antialiasing;
		BAC2.scrollFactor.set(0.4, 0.4);
		BAC2.scale.set(1.8, 1.8);
		BAC2.updateHitbox();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), BAC2);
	}
	
	var ROC3:FlxSprite = new FlxSprite(-1550, -1050).loadGraphic(Paths.image(getVar('stageDir') + '/ROC3'));
	ROC3.antialiasing = ClientPrefs.data.antialiasing;
	ROC3.scrollFactor.set(0.5, 0.5);
	ROC3.scale.set(1.8, 1.8);
	ROC3.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), ROC3);
	
	var TREE4:FlxSprite = new FlxSprite(-1950, -1200).loadGraphic(Paths.image(getVar('stageDir') + '/TREE4'));
	TREE4.antialiasing = ClientPrefs.data.antialiasing;
	TREE4.scrollFactor.set(0.8, 0.8);
	TREE4.scale.set(1.8, 1.8);
	TREE4.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), TREE4);

	var GROUMD5:FlxSprite = new FlxSprite(-2150, -1330).loadGraphic(Paths.image(getVar('stageDir') + '/GROUMD5'));
	GROUMD5.antialiasing = ClientPrefs.data.antialiasing;
	GROUMD5.scale.set(1.8, 1.8);
	GROUMD5.updateHitbox();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), GROUMD5);

	if (!ClientPrefs.data.lowQuality) {	
		var BLURROC6:FlxSprite = new FlxSprite(-2650, -1450).loadGraphic(Paths.image(getVar('stageDir') + '/BLURROC6'));
		BLURROC6.antialiasing = ClientPrefs.data.antialiasing;
		BLURROC6.scrollFactor.set(1.5, 1.5);
		BLURROC6.scale.set(1.8, 1.8);
		BLURROC6.updateHitbox();
		add(BLURROC6);
	}

	return;
}