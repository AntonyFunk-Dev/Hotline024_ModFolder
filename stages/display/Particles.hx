import flixel.group.FlxTypedSpriteGroup;
import openfl.geom.Point;
import psychlua.LuaUtils;

var partImage:String = 'particle';
var partLimit:Int = 50;
var partPosLimit:Float = -2300;
var partPos:Array<Array<Float>> = [[1200, -2000], [2500, 3000]];
var partVelocity:Array<Array<Float>> = [[-50, 50], [-250, -1250]];

var partsGroup:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup();
var twns:Array<FlxTween> = [];

setVar('particlesGroup', partsGroup);

function onCreate() {
	for (i in 0...partLimit) {
		var part:FlxSprite = new FlxSprite().loadGraphic(Paths.image(getVar('stageDir') + '/' + partImage));
		part.visible = false;
		partsGroup.add(part);
		
		twns.push(var twn:FlxTween = null);
	}

	return;
}

function onUpdate() {
	for (part in partsGroup.members) {
		if (!part.visible) continue;

		if (part.y < partPosLimit || (part.scale.x == 0 && part.scale.y == 0)) {
			part.visible = false;
		}
	}

	return;
}

function onStepHit() if (curStep % 2 == 0) spawnParticle();

function spawnParticle() {
	for (part in partsGroup.members) {
		if (!part.visible) {
			part.setPosition(FlxG.random.float(partPos[0][0], partPos[0][1]), FlxG.random.float(partPos[1][0], partPos[1][1]));
			part.visible = true;
			part.velocity.set(FlxG.random.float(partVelocity[0][0], partVelocity[0][1]), FlxG.random.float(partVelocity[1][0], partVelocity[1][1]));
			part.scale.x = part.scale.y = FlxG.random.float(0.5, 1.8);

			if (twns[partsGroup.members.indexOf(part)] != null && twns[partsGroup.members.indexOf(part)].active) twns[partsGroup.members.indexOf(part)].cancel();
			twns[partsGroup.members.indexOf(part)] = FlxTween.tween(part.scale, {x: 0, y: 0}, FlxG.random.float(1, 5), {startDelay: (Conductor.crochet / 1000) * FlxG.random.int(5, 15)});

			break;
		}
	}
	
	return;
}