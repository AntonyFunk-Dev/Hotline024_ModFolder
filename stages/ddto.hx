import psychlua.LuaUtils;

function onCreate() {
	var DDLC_1:FlxSprite = new FlxSprite(70, 70).loadGraphic(Paths.image(getVar('stageDir') + '/DDLC_1'));
	DDLC_1.antialiasing = ClientPrefs.data.antialiasing;
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), DDLC_1);

	if (!ClientPrefs.data.lowQuality) {
		var DDLC_2:FlxSprite = new FlxSprite(150, 150).loadGraphic(Paths.image(getVar('stageDir') + '/DDLC_2'));
		DDLC_2.antialiasing = ClientPrefs.data.antialiasing;
		DDLC_2.scrollFactor.set(1.3, 1.3);
		add(DDLC_2);

		/*var DDLC_3:FlxSprite = new FlxSprite(-100, 20).loadGraphic(Paths.image(getVar('stageDir') + '/DDLC_3'));
		DDLC_3.antialiasing = ClientPrefs.data.antialiasing;
		DDLC_3.scale.set(1.2, 1.2);
		DDLC_3.updateHitbox();
		add(DDLC_3);*/
	}

	return;
}