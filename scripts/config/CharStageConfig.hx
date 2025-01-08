var stage:Array<Dynamic> = [
    getVar('stageData').boyfriend,
    getVar('stageData').opponent,
    getVar('stageData').girlfriend
];

function onCreatePost() {
    for (i in 0...3) if (getChar(i) != null) initCharStageConfig(i, getChar(i));

    return;
}

function onEvent(name, value1, value2) {
	if (name == 'Change Character') {
        switch (value1.toLowerCase()) {
            case 'gf', 'girlfriend':
                if (game.gf != null) initCharStageConfig(2, game.gf);
            case 'dad', 'opponent':
                if (game.dad != null) initCharStageConfig(1, game.dad);
            default:
                if (game.boyfriend != null) initCharStageConfig(0, game.boyfriend);
        }
    }

    return;
}

var orderArray:Array<Dynamic> = [];
function initCharStageConfig(charType:Int = 0, ?char:Character = null) {
    if (stage[charType] == null || char == null) return;

    if (char.animationsArray != null && char.animationsArray.length > 0 && stage[charType].scale != null) {
        if (stage[charType].scale != char.jsonScale) {
            char.scale.set(stage[charType].scale, stage[charType].scale);
            char.updateHitbox();
            
            for (anim in char.animationsArray) {
                if (anim.offsets != null && anim.offsets.length > 1) {
                    char.addOffset(anim.anim, anim.offsets[0] * (char.scale.x / char.jsonScale), anim.offsets[1] * (char.scale.y / char.jsonScale));
                } else {
                    char.addOffset(anim.anim, 0, 0);
                }
            }

            if (char.animOffsets.exists(char.getAnimationName())) {
                var daOffset = char.animOffsets.get(char.getAnimationName());
                char.offset.set(daOffset[0], daOffset[1]);
            }
        }
    }

    if (stage[charType].scrollFactor != null) {
        if (stage[charType].scrollFactor.length > 0) {
            char.scrollFactor.x = stage[charType].scrollFactor[0] ?? char.scrollFactor.x;
            char.scrollFactor.y = stage[charType].scrollFactor[1] ?? char.scrollFactor.y;
        } else {
            char.scrollFactor.x = char.scrollFactor.y = stage[charType].scrollFactor;
        }
    }
}