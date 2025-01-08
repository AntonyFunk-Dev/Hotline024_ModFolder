import flixel.util.FlxGradient;

var oneClick:Bool = true;

var isTransIn:Bool = false;
var transBlack:FlxSprite;
var transGradient:FlxSprite;

var duration:Float;

function onCreate() {
 makeFadeTransition(0.6, true);
}

function onUpdate(elapsed) {
 updateFadeTransition(elapsed);
}

function onCustomSubstateCreate(name) if (name == "h024CharSelectSubstate") makeFadeTransition(0.6, true);

function onCustomSubstateUpdate(name, elapsed) {
 if (name == "h024CharSelectSubstate") {
	if (keyJustPressed("ACCEPT") && oneClick) {
	 FlxG.sound.music.stop();
	 makeFadeTransition(0.6, false);
	 oneClick = false;
	}
	updateFadeTransition(elapsed);
 }
}

function onCustomSubstateDestroy(name) {
 if (name == "h024CharSelectSubstate") {
	makeFadeTransition(0.6, true);
 }
}

function makeFadeTransition(durationF:Float, isTransInF:Bool) {
 duration = durationF;
 isTransIn = isTransInF;

 var width:Int = Std.int(FlxG.width / Math.max(camera.zoom, 0.001));
 var height:Int = Std.int(FlxG.height / Math.max(camera.zoom, 0.001));

 game.remove(transGradient);
 game.remove(transBlack);

 transGradient = FlxGradient.createGradientFlxSprite(1, height, (isTransIn ? [0x0, FlxColor.BLACK] : [FlxColor.BLACK, 0x0]));
 transGradient.cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
 transGradient.scale.x = width;
 transGradient.updateHitbox();
 transGradient.scrollFactor.set();
 transGradient.screenCenter(0x01);
 add(transGradient);

 transBlack = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
 transBlack.cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
 transBlack.scale.set(width, height + 400);
 transBlack.updateHitbox();
 transBlack.scrollFactor.set();
 transBlack.screenCenter(0x01);
 add(transBlack);

 if (isTransIn)
	transGradient.y = transBlack.y - transBlack.height;
 else
	transGradient.y = -transGradient.height;
}

function updateFadeTransition(elapsed) {
 var height:Float = FlxG.height * Math.max(camera.zoom, 0.001);
 var targetPos:Float = transGradient.height + 50 * Math.max(camera.zoom, 0.001);
 if (duration > 0)
	transGradient.y += (height + targetPos) * elapsed / duration;
 else
	transGradient.y = (targetPos) * elapsed;

 if (isTransIn)
	transBlack.y = transGradient.y + transGradient.height;
 else
	transBlack.y = transGradient.y - transBlack.height;

 if (transGradient.y >= targetPos) {
	transGradient.y = targetPos;
	if (!isTransIn) {
	 CustomSubstate.closeCustomSubstate();
	} else {
	 game.remove(transGradient);
	 transGradient.kill();
	 transGradient.destroy();
	 game.remove(transBlack);
	 transBlack.kill();
	 transBlack.destroy();
	}
 }
}