import openfl.geom.Point;
import psychlua.LuaUtils;

var rockImage:String = 'ast';
var rockLimit:Int = 15;
var rockPosLimit:Float = -2000;
var rockPos:Array<Array<Float>> = [[1200, 1500], [350, 1250]];
var rockVelocity:Array<Array<Float>> = [-6500, -3000];

var rocksArray:Array<FlxSprite> = [];
var twns:Array<FlxTween> = [];

var rockSpawn:Bool = false;

var spawnTimer:Float = 0;
var stopTimer:Float = 0;

function onCreate() {
	for (i in 0...rockLimit) {
		var rock:FlxSprite = new FlxSprite();
		rock.visible = false;

		rocksArray.push(rock);
		twns.push(var twn:FlxTween = null);

		insert(game.members.indexOf(LuaUtils.getLowestCharacterGroup()) + FlxG.random.int(2, 5), rock);
	}

	stopTimer = FlxG.random.int(10, 30);
	spawnTimer = FlxG.random.int(10, 20);

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

	for (rock in rocksArray) {
		if (!rock.visible) continue;

		if (rock.x < rockPosLimit) {
			rock.visible = false;
		}
	}

	return;
}

function onStepHit() if (rockSpawn) spawnRocks();

var rndImage:Int = 0;
function spawnRocks() {
	for (rock in rocksArray) {
		if (!rock.visible) {
			rndImage = FlxG.random.int(1, 3);
		
			rock.loadGraphic(Paths.image(getVar('stageDir') + '/' + (rockImage + rndImage)));
			rock.setPosition(FlxG.random.int(rockPos[0][0], rockPos[0][1]), FlxG.random.int(rockPos[1][0], rockPos[1][1]));
			rock.velocity.set(rockVelocity[0], rockVelocity[1]);
			rock.angularVelocity = FlxG.random.int(-50, 50);
			rock.flipX = FlxG.random.bool();
			rock.flipY = FlxG.random.bool();
			rock.scale.x = rock.scale.y = FlxG.random.float(2, 2.2);
			if (rndImage == 1) rock.scale.x = rock.scale.y -= FlxG.random.float(1.1, 1.3);

			rock.visible = true;

			break;
		}
	}
	
	return;
}