import flixel.group.FlxTypedSpriteGroup;
import psychlua.LuaUtils;

var rockImage:String = 'ast';
var rocksLimit:Int = 15;
var rockPosLimit:Float = -2000;
var rockPos:Array<Array<Float>> = [[1200, 1500], [350, 1250]];
var rockVelocity:Array<Array<Float>> = [-6500, -3000];

var rocksBack:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup();
var rocksFront:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup();

var rockSpawn:Bool = false;

var spawnTimer:Float = 0;
var stopTimer:Float = 0;

function onCreatePost() {
	stopTimer = FlxG.random.int(10, 30);
	spawnTimer = FlxG.random.int(10, 20);

	insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()), rocksBack);

	add(rocksFront);

	for (i in 0...rocksLimit) {
		var rock:FlxSprite = new FlxSprite();
		rock.visible = false;

		if (i < (rocksLimit / 2)) rocksBack.add(rock);
		else rocksFront.add(rock);
	}

	return;
}

function onUpdate(elapsed) {
	if (rockSpawn) {
		spawnTimer -= elapsed;

		if (spawnTimer <= 0) {
			rockSpawn = false;
			stopTimer = FlxG.random.int(10, 30);
		}
	} else {
		stopTimer -= elapsed;

		if (stopTimer <= 0) {
			rockSpawn = true;
			spawnTimer = FlxG.random.int(10, 20);
		}
	}

	for (rock in rocksBack.members) {
		if (!rock.visible) continue;

		if (rock.x < rockPosLimit) {
			rock.visible = false;
		}
	}

	for (rock in rocksFront.members) {
		if (!rock.visible) continue;

		if (rock.x < rockPosLimit) {
			rock.visible = false;
		}
	}

	return;
}

function onStepHit() if (rockSpawn) spawnRocks();

var randomSpr:Int = 0;
function spawnRocks() {
	for (rock in rocksBack.members) {
		if (!rock.visible) {
			logicRock(rock);

			break;
		}
	}

	for (rock in rocksFront.members) {
		if (!rock.visible) {
			logicRock(rock);

			break;
		}
	}
	
	return;
}

function logicRock(rock:FlxSprite) {
	randomSpr = FlxG.random.int(1, 3);
	
	rock.loadGraphic(Paths.image(getVar('stageDir') + '/' + (rockImage + randomSpr)));
	rock.setPosition(FlxG.random.int(rockPos[0][0], rockPos[0][1]), FlxG.random.int(rockPos[1][0], rockPos[1][1]));
	rock.velocity.set(rockVelocity[0], rockVelocity[1]);
	rock.angularVelocity = FlxG.random.int(-50, 50);
	rock.flipX = FlxG.random.bool();
	rock.flipY = FlxG.random.bool();
	rock.scale.x = rock.scale.y = FlxG.random.float(2, 2.2);
	if (randomSpr == 1) rock.scale.x = rock.scale.y -= FlxG.random.float(1.1, 1.3);

	rock.visible = true;

}