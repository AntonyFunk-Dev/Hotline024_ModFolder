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
	}

	return;
}