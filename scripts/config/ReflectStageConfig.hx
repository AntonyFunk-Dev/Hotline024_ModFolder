import psychlua.LuaUtils;

var refl:Array<Dynamic> = [
	getVar('stageData').boyfriend.reflect,
	getVar('stageData').opponent.reflect,
	getVar('stageData').girlfriend.reflect
];

var charReflStr:Array<String> = ['boyfriendReflect', 'dadReflect', 'gfReflect'];

var charRefl:Array<Character> = [];

function onCreatePost() {
	for (i in 0...3) if (!isJsonEmpty(refl[i]) && getChar(i) != null) initReflectConfig(charReflStr[i], i, getChar(i));

	return;
}

function onUpdatePost() {
	for (i in 0...3) if (!isJsonEmpty(refl[i]) && getChar(i) != null) updateReflectConfig(i, getChar(i));

	return;
}

function onEvent(name, value1, value2) {
	if (name == 'Change Character') {
		switch(value1.toLowerCase()) {
			case 'gf' | 'girlfriend':
				if (!isJsonEmpty(refl[2]) && game.gf != null) initReflectConfig(charReflStr[2], 2, game.gf);
			case 'dad' | 'opponent':
				if (!isJsonEmpty(refl[1]) && game.dad != null) initReflectConfig(charReflStr[1], 1, game.dad);
			default:
				if (!isJsonEmpty(refl[0]) && game.boyfriend != null) initReflectConfig(charReflStr[0], 0, game.boyfriend);
		}
	}

	return;
}

function initReflectConfig(tag:String = '', ?charType:Int = 0, ?char:Character = null) {   
	if (charRefl[charType] != null) {
		remove(charRefl[charType]);
		charRefl[charType].kill();
		charRefl[charType].destroy();
		charRefl[charType] = null;

		removeVar(tag);
	}

	charRefl[charType] = char.clone();
	charRefl[charType].scrollFactor.set(char.scrollFactor.x, char.scrollFactor.y);
	charRefl[charType].scale.set(char.scale.x, char.scale.y);
	charRefl[charType].updateHitbox();
	charRefl[charType].flipY = true;
	charRefl[charType].flipX = char.flipX;
	charRefl[charType].x = char.x;
	charRefl[charType].alpha = (refl[charType].alpha ?? 1.0);
	if (ClientPrefs.data.shaders) charRefl[charType].blend = LuaUtils.blendModeFromString(refl[charType].blend ?? '');

	switch(charType) {
		case 2:
			addBehindGF(charRefl[charType]);
		case 1:
			addBehindDad(charRefl[charType]);
		default:
			addBehindBF(charRefl[charType]);
	}

	setVar(tag, charRefl[charType]);
}

function updateReflectConfig(?charType:Int = 0, ?char:Character = null) {
	if (charRefl[charType] != null) {
		charRefl[charType].animation.frameName = char.animation.frameName;

		switch(charType) {
			case 2:
				charRefl[charType].y = ((char.positionArray[1] + game.gfGroup.y) - char.y) + (refl[charType].offsetY ?? 0);
			case 1:
				charRefl[charType].y = ((char.positionArray[1] + game.dadGroup.y) - char.y) + (refl[charType].offsetY ?? 0);
			default:
				charRefl[charType].y = ((char.positionArray[1] + game.boyfriendGroup.y) - char.y) + (refl[charType].offsetY ?? 0);
		}

		charRefl[charType].offset.x = char.offset.x;
		charRefl[charType].offset.y = (char.frameHeight * char.scale.y) - char.offset.y;
	}
}