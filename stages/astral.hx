import psychlua.LuaUtils;

var BG:FlxSprite;
var idk:FlxSprite = null;
var ground:FlxSprite = null;
var messages:FlxSprite;
var door:FlxSprite;
var DES:FlxSprite;
var PLAMTS:FlxSprite = null;

function onCreate() {
	BG = new FlxSprite(-200, -70).loadGraphic(Paths.image(getVar('stageDir') + '/BG'));
	BG.antialiasing = ClientPrefs.data.antialiasing;
	BG.scrollFactor.set(0.5, 0.5);
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), BG);

	if (!ClientPrefs.data.lowQuality) {
		idk = new FlxSprite(-150, -200).loadGraphic(Paths.image(getVar('stageDir') + '/2/idk'));
		idk.antialiasing = ClientPrefs.data.antialiasing;
		idk.scrollFactor.set(0.6, 0.6);
		idk.kill();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), idk);

		ground = new FlxSprite(-105, -50).loadGraphic(Paths.image(getVar('stageDir') + '/2/ground'));
		ground.antialiasing = ClientPrefs.data.antialiasing;
		ground.scrollFactor.set(0.7, 0.7);
		ground.kill();
		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), ground);
	}
	
	messages = new FlxSprite(-30, -40).loadGraphic(Paths.image(getVar('stageDir') + '/2/messages'));
	messages.antialiasing = ClientPrefs.data.antialiasing;
	messages.scrollFactor.set(0.9, 0.9);
	messages.kill();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), messages);

	door = new FlxSprite(-50, -50).loadGraphic(Paths.image(getVar('stageDir') + '/2/door'));
	door.antialiasing = ClientPrefs.data.antialiasing;
	door.scrollFactor.set(0.8, 0.8);
	door.kill();
	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), door);

	DES = new FlxSprite(20, 20).loadGraphic(Paths.image(getVar('stageDir') + '/DES'));
	DES.antialiasing = ClientPrefs.data.antialiasing;
	DES.scrollFactor.set(1.1, 1.1);
	add(DES);

	if (!ClientPrefs.data.lowQuality) {
		PLAMTS = new FlxSprite(150, 50).loadGraphic(Paths.image(getVar('stageDir') + '/PLAMTS'));
		PLAMTS.antialiasing = ClientPrefs.data.antialiasing;
		PLAMTS.scrollFactor.set(1.5, 1.5);
		add(PLAMTS);
	}

	return;
}

function onEvent(name, value1, value2) {
	if (name == "Astral Event") {
		switch(value2) {
			case '0':
				BG.loadGraphic(Paths.image(getVar('stageDir') + '/BG'));
				DES.loadGraphic(Paths.image(getVar('stageDir') + '/DES'));
				if (PLAMTS != null) PLAMTS.loadGraphic(Paths.image(getVar('stageDir') + '/PLAMTS'));
	
				if (idk != null) idk.kill();
				if (ground != null) ground.kill();
				messages.kill();
				door.kill();
			case '1':
				BG.loadGraphic(Paths.image(getVar('stageDir') + '/2/BG1'));
				DES.loadGraphic(Paths.image(getVar('stageDir') + '/2/desk2'));
				if (PLAMTS != null) PLAMTS.loadGraphic(Paths.image(getVar('stageDir') + '/2/plamts2'));
	
				if (idk != null) idk.revive();
				if (ground != null) ground.revive();
				messages.revive();
				door.revive();
		}		
	}

	return;
}