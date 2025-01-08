import tjson.TJSON as Json;
import flixel.util.FlxGradient;

var dir:String = 'menus/skins/';

var settingsData:Dynamic = Json.parse(File.getContent(Paths.modFolders('data/settings.json')));
var charType:Array<String> = [];

for (data in settingsData) {
	if (data.save == 'h024NikkuStyle')
	charType = data.options;
}

for (i in 0...4) charType[i] = Paths.formatToSongPath(charType[i]);

var menuItems:Array<FlxSprite> = [];
var menuSkins:Array<Dynamic> = [
	{char: charType[0], skin: dir + 'nikku'},
	{char: charType[1], skin: dir + 'nikku2'},
	{char: charType[2], skin: dir + 'jojo'},
	{char: charType[3], skin: dir + 'classic'}
];

var twnsArray:Array<FlxTween> = [];

var curSelected:Int = charType.indexOf(Paths.formatToSongPath(getModSetting('h024NikkuStyle')));
var isClicked:Bool = false;
var isSubstate:Bool = true;

var transGrad:FlxSprite = new FlxSprite();
var transBlack:FlxSprite = new FlxSprite();

var char:FlxSprite;
var shadChar:FlxSprite;
var triangle_0:FlxSprite;
var triangle_1:FlxSprite;

function onCreate() {
	game.camGame.kill();
	game.camHUD.kill();

	for (i in 0...4) twnsArray.push(var twn:FlxTween = null);

	return;
}

function onUpdate(elapsed) {
	if (isSubstate) CustomSubstate.openCustomSubstate('NikkuStyleSubstate', true);

	if (!ClientPrefs.data.lowQuality) updateTransition();

	return;
}

function onCustomSubstateCreate(name) {
	if (name == 'NikkuStyleSubstate') {
		isSubstate = false;
		
		FlxG.sound.playMusic(Paths.music('nightlight'));
		
		FlxG.save.data.nikkuStyle = selectSkin().char;
		FlxG.save.flush();

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image(dir + 'bg'));
		menuItems.push(bg);

		shadChar = new FlxSprite().loadGraphic(Paths.image(menuSkins[curSelected].skin + 'Shadow'));
		shadChar.offset.x -= 5;
		menuItems.push(shadChar);

		char = new FlxSprite().loadGraphic(Paths.image(menuSkins[curSelected].skin));
		menuItems.push(char);

		var bars:FlxSprite = new FlxSprite().loadGraphic(Paths.image(dir + 'bars'));
		menuItems.push(bars);

		var choose:FlxSprite = new FlxSprite().loadGraphic(Paths.image(dir + 'choose'));
		menuItems.push(choose);

		triangle_0 = new FlxSprite(787, 506).loadGraphic(Paths.image(dir + 'triangle'));
		menuItems.push(triangle_0);

		triangle_1 = new FlxSprite(1177, 507).loadGraphic(Paths.image(dir + 'triangle'));
		triangle_1.flipX = true;
		menuItems.push(triangle_1);

		for (item in menuItems) {
			item.cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
			item.antialiasing = ClientPrefs.data.antialiasing;
			add(item);
		}

		if (!ClientPrefs.data.lowQuality) createTransition(0.6, true);
	}

	return;
}

function onCustomSubstateUpdate(name, elapsed) {
	if (name == 'NikkuStyleSubstate') { 	
		if (keyJustPressed("UI_LEFT") || keyJustPressed("UI_RIGHT")) {
			changeSelection((keyJustPressed('UI_LEFT') ? -1 : 1));
			selectSkin((keyJustPressed('UI_LEFT') ? 1 : -1));
		}

		if (!isClicked && keyJustPressed('ACCEPT')) {
			isClicked = !isClicked;

			FlxG.sound.music.stop();
			triggerSelectSound();

			if (!ClientPrefs.data.lowQuality) createTransition(0.6, false, true);
			else CustomSubstate.closeCustomSubstate();
		}

		if (!ClientPrefs.data.lowQuality) updateTransition();
	}

	return;
}

function onCustomSubstateDestroy(name) {
	if (name == 'NikkuStyleSubstate') {
		for (item in menuItems) {
			remove(item);
			item.kill();
			item.destroy();
		}

		FlxG.save.data.nikkuStyle = selectSkin().char;
		FlxG.save.flush();

		PlayState.SONG.player2 = FlxG.save.data.nikkuStyle;
		game.triggerEvent('Change Character', 'opponent', PlayState.SONG.player2);

		settingsData = charType = menuItems = menuSkins = twnsArray = null;

		game.camGame.revive();
		game.camHUD.revive();
	}

	return;
}

function changeSelection(?change:Int = 0) {
	if (Std.int(change) != 0) triggerSelectSound(null, 0.4, 'scrollMenu');

	curSelected += change;

	if (curSelected < 0)
		curSelected = menuSkins.length - 1;
	if (curSelected >= menuSkins.length)
		curSelected = 0;
}

var object:Dynamic = null;
var number:Int = 0;
function selectSkin(?conduct:Int = null) {
	if (conduct != null) {
		char.loadGraphic(Paths.image(menuSkins[curSelected].skin));
		shadChar.loadGraphic(Paths.image(menuSkins[curSelected].skin + 'Shadow'));

		shadChar.alpha = char.alpha = 0.65;

		shadChar.x = (5 * conduct);
		if (twnsArray[0] != null && twnsArray[0].active) twnsArray[0].cancel();
		twnsArray[0] = FlxTween.tween(shadChar, {x: 0, alpha: 1}, 1.85, {ease: FlxEase.expoOut});

		char.x = (40 * conduct);
		if (twnsArray[1] != null && twnsArray[1].active) twnsArray[1].cancel();
		twnsArray[1] = FlxTween.tween(char, {x: 0, alpha: 1}, 0.85, {ease: FlxEase.expoOut});

		object = (conduct != -1 ? triangle_0 : triangle_1);
		number = (conduct != -1 ? 2 : 3);
	
		object.offset.y -= 5;
		if (twnsArray[number] != null && twnsArray[number].active) twnsArray[number].cancel();
		twnsArray[number] = FlxTween.tween(object.offset, {y: 0}, 1, {ease: FlxEase.expoOut});
	}

	return menuSkins[curSelected];
}

var isTransIn:Bool = false;
var selectFinish:Bool = false;
var duration:Float = 0;
function createTransition(dur:Float, ?transIn:Bool = false, ?selectEnd:Bool = null) {
	duration = dur;
	isTransIn = transIn;
	selectFinish = selectEnd;

	var width:Int = Std.int(FlxG.width / Math.max(camera.zoom, 0.001));
	var height:Int = Std.int(FlxG.height / Math.max(camera.zoom, 0.001));

	if (transGrad != null) transGrad.destroy();
	if (transBlack != null) transBlack.destroy();

	transGrad = FlxGradient.createGradientFlxSprite(1, height, (isTransIn ? [0x0, FlxColor.BLACK] : [FlxColor.BLACK, 0x0]));
	transGrad.cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	transGrad.scale.x = width;
	transGrad.updateHitbox();
	transGrad.scrollFactor.set();
	transGrad.screenCenter(0x01);
	add(transGrad);

	transBlack = new FlxSprite().makeGraphic(1, 1, FlxColor.BLACK);
	transBlack.cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	transBlack.scale.set(width, height + 400);
	transBlack.updateHitbox();
	transBlack.scrollFactor.set();
	transBlack.screenCenter(0x01);
	add(transBlack);

	if (isTransIn)
	transGrad.y = transBlack.y - transBlack.height;
	else
	transGrad.y = -transGrad.height;
}

function updateTransition() {
	if (!transGrad.exists || !transBlack.exists) return;

	final height:Float = FlxG.height * Math.max(camera.zoom, 0.001);
	final targetPos:Float = transGrad.height + 50 * Math.max(camera.zoom, 0.001);

	if (duration > 0)
		transGrad.y += (height + targetPos) * FlxG.elapsed / duration;
	else
		transGrad.y = (targetPos) * FlxG.elapsed;

	if (isTransIn)
		transBlack.y = transGrad.y + transGrad.height;
	else
		transBlack.y = transGrad.y - transBlack.height;

	if (transGrad.y >= targetPos) {		
		for (obj in [transGrad, transBlack]) {
			remove(obj);
			obj.kill();
			obj.destroy();
		}

		if (selectFinish) {
			selectFinish = false;

			CustomSubstate.closeCustomSubstate();

			createTransition(0.6, true);
		}
	}
}