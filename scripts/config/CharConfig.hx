import tjson.TJSON as Json;
import psychlua.LuaUtils;

var charArray:Array<Dynamic> = [
	{dir: '', posY: 0}, 
	{dir: '', posY: 0}, 
	{dir: '', posY: 0}
];

var charJson:Array<Dynamic> = [null, null, null];

var tweens:Array<FlxTween> = [];

function onCreatePost() {
	for (i in 0...3) tweens.push(var twn:FlxTween = null);

	initCharConfig(0, game.boyfriend);

	initCharConfig(1, game.dad);

	if (game.gf != null) initCharConfig(2, game.gf);

	return;
}

function onBeatHit() {
	if (ClientPrefs.data.lowQuality) return;

	if (getTypeChar(0) == 1) {
		if (tweens[0] != null && tweens[0].active) tweens[0].cancel();

		if (charJson[0].amount.length > 0)
		game.boyfriend.y = charArray[0].posY + (charJson[0].amount != null ? FlxG.random.float(charJson[0].amount[0], charJson[0].amount[1], charJson[0].amount[2]) : 0);
		else
		game.boyfriend.y = charArray[0].posY + (charJson[0].amount != null ? charJson[0].amount : 0);
		
		tweens[0] = FlxTween.tween(game.boyfriend, {y: charArray[0].posY}, 
			(charJson[0].speed != null ? charJson[0].speed : 1.0), {
				ease: LuaUtils.getTweenEaseByString(charJson[0].ease)
			}
		);
	}
	
	if (getTypeChar(1) == 1) {
		if (tweens[1] != null && tweens[1].active) tweens[1].cancel();

		if (charJson[1].amount.length > 0)
		game.dad.y = charArray[1].posY + (charJson[1].amount != null ? FlxG.random.float(charJson[1].amount[0], charJson[1].amount[1], charJson[1].amount[2]) : 0);
		else
		game.dad.y = charArray[1].posY + (charJson[1].amount != null ? charJson[1].amount : 0);

		tweens[1] = FlxTween.tween(game.dad, {y: charArray[1].posY}, 
			(charJson[1].speed != null ? charJson[1].speed : 1.0), {
				ease: LuaUtils.getTweenEaseByString(charJson[1].ease)
			}
		);
	}
	
	if (getTypeChar(2) == 1 && game.gf != null) {
		if (tweens[2] != null && tweens[2].active) tweens[2].cancel();

		if (charJson[2].amount.length > 0)
		game.gf.y = charArray[2].posY + (charJson[2].amount != null ? FlxG.random.float(charJson[2].amount[0], charJson[2].amount[1], charJson[2].amount[2]) : 0);
		else
		game.gf.y = charArray[2].posY + (charJson[2].amount != null ? charJson[2].amount : 0);

		tweens[2] = FlxTween.tween(game.gf, {y: charArray[2].posY}, 
			(charJson[2].speed != null ? charJson[2].speed : 1.0), {
				ease: LuaUtils.getTweenEaseByString(charJson[2].ease)
			}
		);
	}

	return;
}

function onEvent(name, value1, value2) {
	if (name == 'Change Character') {
		switch(value1.toLowerCase()) {
			case 'gf' | 'girlfriend':
				if (game.gf != null) initCharConfig(2, game.gf);
			case 'dad' | 'opponent':
				initCharConfig(1, game.dad);
			default:
				initCharConfig(0, game.boyfriend);
		}
	}

	return;
}

function initCharConfig(?charType:Int = 0, ?char:Character = null) {
	charArray[charType].dir = 'characters/config/' + char.curCharacter + '.json';
	charArray[charType].posY = char.y;

	if (!Paths.fileExists(charArray[charType].dir)) {
		if (tweens[charType] != null && tweens[charType].active) {
			tweens[charType].cancel();
			tweens[charType] = null;
		}
		return;
	}

	charJson[charType] = Json.parse(File.getContent(Paths.modFolders(charArray[charType].dir)));

	if (charJson[charType] != null && charJson[charType].type != 1) {
		if (tweens[charType] != null && tweens[charType].active) tweens[charType].cancel();
		tweens[charType] = FlxTween.tween(char, {y: (charArray[charType].posY + (charJson[charType].amount != null ? charJson[charType].amount : 0))}, 
			(charJson[charType].speed != null ? charJson[charType].speed : 1.0) * FlxG.random.float(0.85, 1.2), {
				ease: LuaUtils.getTweenEaseByString(charJson[charType].ease),
				type: LuaUtils.getTweenTypeByString('pingpong')
			}
		);
	}
}

function getTypeChar(?charType:Int = 0) {
	if (charJson[charType] != null && charJson[charType].type != null)
	return charJson[charType].type;

	return null; 
}