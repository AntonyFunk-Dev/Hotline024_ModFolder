var stage:Array<Dynamic> = [
	getVar('stageData').boyfriend,
	getVar('stageData').opponent,
	getVar('stageData').girlfriend
];

var bfPos:Int = 0;
var dadPos:Int = 0;
var gfPos:Int = 0;

function onCreatePost() { 
	bfPos = FlxG.state.members.indexOf(game.boyfriendGroup);
	dadPos = FlxG.state.members.indexOf(game.dadGroup);
	gfPos = FlxG.state.members.indexOf(game.dadGroup);

	initCharStageConfig(0, game.boyfriend);
	initCharStageConfig(1, game.dad);
	if (game.gf != null) initCharStageConfig(2, game.gf);

	return;
}

function onEvent(name, value1, value2) {
	if (name == 'Change Character') {
		switch(value1.toLowerCase()) {
			case 'gf' | 'girlfriend':
				if (game.gf != null) initCharStageConfig(2, game.gf);
			case 'dad' | 'opponent':
				initCharStageConfig(1, game.dad);
			default:
				initCharStageConfig(0, game.boyfriend);
		}
	}

	return;
}

function initCharStageConfig(?charType:Int = 0, ?char:Character = null) {
	if (stage[charType] != null) {  
		if (char.animationsArray != null && char.animationsArray.length > 0 && stage[charType].scale != null) {
			if (stage[charType].scale != char.jsonScale) {
				char.scale.set(stage[charType].scale, stage[charType].scale);
				char.updateHitbox();
				
				for (anim in char.animationsArray) {
					if (anim.offsets != null && anim.offsets.length > 1) {
						var offsets:Array<Float> = [anim.offsets[0], anim.offsets[1]];

						if (anim.offsets != null && anim.offsets.length > 1)
							char.addOffset(anim.anim, offsets[0] * (char.scale.x / char.jsonScale), offsets[1] * (char.scale.y / char.jsonScale));
						else addOffset(anim.anim, 0, 0);
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
				char.scrollFactor.x = (stage[charType].scrollFactor[0] != null ? stage[charType].scrollFactor[0] : char.scrollFactor.x);
				char.scrollFactor.y = (stage[charType].scrollFactor[1] != null ? stage[charType].scrollFactor[1] : char.scrollFactor.y);
			} else {
				char.scrollFactor.x = char.scrollFactor.y = stage[charType].scrollFactor;	  
			}
		}
		
		if (stage[charType].order == null) return;

		var charGroup:Dynamic = null;
		switch(charType) {
			case 2:
				charGroup = game.gfGroup;
			case 1:
				charGroup = game.dadGroup;
			default:
				charGroup = game.boyfriendGroup;
		}

		switch(stage[charType].order) {
			case 2:
				FlxG.state.members[gfPos] = charGroup;
			case 1:
				FlxG.state.members[dadPos] = charGroup;
			default:
				FlxG.state.members[bfPos] = charGroup;
		}
	}
}