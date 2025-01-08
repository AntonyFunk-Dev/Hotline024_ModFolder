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
    for (i in 0...3) if (getChar(i) != null) initCharConfig(i, getChar(i));
    
    return;
}

function onBeatHit() {
    for (i in 0...3) {
        if (getChar(i) == null || getTypeChar(i) != 1) continue;

        if (tweens[i] != null && tweens[i].active) tweens[i].cancel();

        if (charJson[i].amount != null && charJson[i].amount.length > 0) {
            getChar(i).y = charArray[i].posY + FlxG.random.float(charJson[i].amount[0] ?? 0, charJson[i].amount[1] ?? 0, charJson[i].amount[2] ?? 0);
        } else {
            getChar(i).y = charArray[i].posY + (charJson[i].amount ?? 0);
        }

        tweens[i] = FlxTween.tween(getChar(i), {y: charArray[i].posY}, charJson[i].speed ?? 1.0, {
            ease: LuaUtils.getTweenEaseByString(charJson[i].ease ?? 'linear')
        });
    }

    return;
}

function onEvent(name, value1, value2) {
    if (name == 'Change Character') {
        switch (value1.toLowerCase()) {
            case 'gf', 'girlfriend':
                if (game.gf != null) initCharConfig(2, game.gf);
            case 'dad', 'opponent':
                if (game.dad != null) initCharConfig(1, game.dad);
            default:
                if (game.boyfriend != null) initCharConfig(0, game.boyfriend);
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
        tweens[charType] = FlxTween.tween(char, {y: charArray[charType].posY + (charJson[charType].amount ?? 0)}, 
        (charJson[charType].speed ?? 1.0) * FlxG.random.float(0.85, 1.2), {
            ease: LuaUtils.getTweenEaseByString(charJson[charType].ease ?? 'linear'),
            type: LuaUtils.getTweenTypeByString('pingpong')
        });
    }
}

function getTypeChar(charType:Int) {
	return charJson[charType]?.type;
}