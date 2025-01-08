import flixel.text.FlxText;
import flixel.effects.FlxFlicker;
import psychlua.LuaUtils;

var scoreHitData:Map = [
	'sick' => 0,
	'good' => 0,
	'bad' => 0,
	'shit' => 0,
	'miss' => 0,
	'misses' => 0,
	'count' => 0,
	'score' => 0,
	'scoreCPU' => 0,
];

var comboHitNum:Int = 0;

var comboTimer:FlxTimer;

var comboGlow:FlxSprite;
var comboHitTxt:FlxText;
var scoreAmountHitTxt:FlxText;
var scoreHitTxt:FlxText;

function onCreate() {
	comboGlow = new FlxSprite().loadGraphic(Paths.image('ui/comboGlow'));
	comboGlow.antialiasing = ClientPrefs.data.antialiasing;
	if (ClientPrefs.data.shaders) comboGlow.blend = LuaUtils.blendModeFromString('add');
	comboGlow.screenCenter(0x01);
	comboGlow.alpha = 0;

	comboHitTxt = new FlxText(0, 0, FlxG.width);
	comboHitTxt.setFormat(Paths.font('goodbyeDespair.ttf'), 38, FlxColor.WHITE, 'center');
	comboHitTxt.antialiasing = ClientPrefs.data.antialiasing;
	comboHitTxt.alpha = 0;

	scoreAmountHitTxt = new FlxText(0, 0, FlxG.width);
	scoreAmountHitTxt.setFormat(Paths.font('goodbyeDespair.ttf'), 20, FlxColor.WHITE, 'center');
	scoreAmountHitTxt.antialiasing = ClientPrefs.data.antialiasing;
	scoreAmountHitTxt.alpha = 0;

	scoreHitTxt = new FlxText(0, 0, FlxG.width);
	scoreHitTxt.setFormat(Paths.font('goodbyeDespair.ttf'), 38, FlxColor.WHITE, 'center');
	scoreHitTxt.antialiasing = ClientPrefs.data.antialiasing;
	scoreHitTxt.alpha = 0;

	return;
}

var twnArray:Array<FlxTween> = [];
function onCreatePost() {
	for (i in 0...3) twnArray.push(var twn:FlxTween = null);
	if (ClientPrefs.data.lowQuality) comboGlow.kill();

	game.remove(game.comboGroup);

	comboHitTxt.setBorderStyle(getVar('FlxTextBorderStyle').OUTLINE, FlxColor.BLACK, 1.4);
	scoreAmountHitTxt.setBorderStyle(getVar('FlxTextBorderStyle').OUTLINE, FlxColor.BLACK, 1.2);
	scoreHitTxt.setBorderStyle(getVar('FlxTextBorderStyle').OUTLINE, FlxColor.BLACK, 1.4);

	comboGlow.y = game.timeBar.y + (ClientPrefs.data.downScroll ? -125 + (ClientPrefs.data.middleScroll ? -100 : 0) : 25 
	+ (ClientPrefs.data.middleScroll ? 90 : 0));
	comboHitTxt.y = comboGlow.y + (((comboGlow.height - comboHitTxt.height) / 2) + 5) - 25;
	scoreAmountHitTxt.y = comboGlow.y + (((comboGlow.height - scoreAmountHitTxt.height) / 2) + 5);
	scoreHitTxt.y = comboGlow.y + (((comboGlow.height - scoreHitTxt.height) / 2) + 5) + 25;
	game.botplayTxt.y = game.healthBar.y + (ClientPrefs.data.downScroll ? 70 : -90);

	game.uiGroup.add(comboGlow);
	game.uiGroup.add(comboHitTxt);
	game.uiGroup.add(scoreAmountHitTxt);
	game.uiGroup.add(scoreHitTxt);

	comboTimer = new FlxTimer().start(-1, () -> {
		if (!game.startingSong) ratingScore();
	});

	return;
}

function onUpdateScore(noteMiss) {
	if (game.totalPlayed != 0) game.scoreTxt.text = getScoreTxt(scoreHitData.get('score'));

	return;
}

function goodNoteHit(note) comboNote(note);
function noteMiss(note) comboNote(note, true);

var twnCount:FlxTween = null;
var twnScore:FlxTween = null;
var index:Int = 0;
function comboNote(note:Note, ?noteMissed:Bool = false) {
	if (note.missed) return;

	if (FlxFlicker.isFlickering(comboHitTxt)) FlxFlicker.stopFlickering(comboHitTxt);
	if (twnCount != null && twnCount.active) twnCount.cancel();
	if (twnScore != null && twnScore.active) twnScore.cancel();

	if (!note.isSustainNote) for (i in 0...3) if (twnArray[i] != null && twnArray[i].active) twnArray[i].cancel();

	if (!noteMissed) {
		if (!note.isSustainNote) {
			comboHitNum++;
			scoreAmountHitTxt.text = '+' + daRating(note.rating).score + (scoreHitData.get('misses') < 0 ? ' ' + scoreHitData.get('misses') : '');
			scoreHitData.set(note.rating, scoreHitData.get(note.rating) + 1);

			if (!game.cpuControlled && !game.practiceMode) {
				comboHitTxt.text = '' + note.rating + '! x' + comboHitNum;
				scoreHitData.set('count', scoreHitData.get('count') + daRating(note.rating).score);

				comboHitTxt.scale.x = scoreAmountHitTxt.scale.x = scoreHitTxt.scale.x = 1.075;
				comboHitTxt.scale.y = scoreAmountHitTxt.scale.y = scoreHitTxt.scale.y = 1.075;

				index = 0;
				for (obj in [comboHitTxt, scoreAmountHitTxt, scoreHitTxt]) {
					if (twnArray[index] != null && twnArray[index].active) twnArray[index].cancel();
					twnArray[index] = FlxTween.tween(obj.scale, {x: 1, y: 1}, 0.2, {ease: FlxEase.linear});
				
					index++;
				}
			} else {
				comboHitNum = 0;
				comboHitTxt.text = note.rating + '!';
				scoreHitData.set('scoreCPU', scoreHitData.get('scoreCPU') + daRating(note.rating).score);
			}

		}
	} else {
		comboHitNum = 0;
		scoreHitData.set('miss', scoreHitData.get('miss') + 1);
		scoreHitData.set('misses', scoreHitData.get('misses') - 10);
		comboHitTxt.text = 'Miss!...';

		scoreHitData.set((!game.cpuControlled && !game.practiceMode ? 'count' : 'scoreCPU'), 
		scoreHitData.get((!game.cpuControlled && !game.practiceMode ? 'count' : 'scoreCPU')) - 10);

		if (scoreHitData.get('misses') < 0) scoreAmountHitTxt.text = '' + scoreHitData.get('misses');
	}

	comboTimer.reset(((Conductor.crochet / 1000) * 4));
	comboGlow.alpha = (ClientPrefs.data.middleScroll ? 0.15 : 0.25);
	comboHitTxt.alpha = scoreAmountHitTxt.alpha = scoreHitTxt.alpha = (ClientPrefs.data.middleScroll ? 0.7 : 1.0);

	scoreHitTxt.text = '' + scoreHitData.get((!game.cpuControlled && !game.practiceMode ? 'count' : 'scoreCPU'));

	return;
}

var twnSecNum:Float = 0;
function ratingScore() {	
	comboHitNum = 0;

	comboGlow.alpha = 0.45;
	comboHitTxt.alpha = scoreHitTxt.alpha = 1.0;
	scoreAmountHitTxt.alpha = 0;

	comboHitTxt.text = 'Whoops...';
	if (scoreHitData.get('shit') > 0 || scoreHitData.get('miss') >= 10)
	comboHitTxt.text = comboHitTxt.text;
	else if (scoreHitData.get('bad') > 0)
	comboHitTxt.text = 'NICE!';
	else if (scoreHitData.get('good') > 0)
	comboHitTxt.text = 'GREAT!';
	else if (scoreHitData.get('sick') > 0)
	(scoreHitData.get('miss') > 0 ? comboHitTxt.text = 'GREAT!' : comboHitTxt.text = 'PERFECT!!');
	
	if (!game.cpuControlled && !game.practiceMode) {
		twnSecNum = 0.1 + ((0.75 - 0.1) * Math.min((scoreHitData.get('count') / 35000), 1));

		twnCount = FlxTween.num(scoreHitData.get('count'), 0, twnSecNum, {
			ease: FlxEase.circOut,
			onUpdate: () -> {
				scoreHitTxt.text = '' + Std.int(twnCount.value);
				scoreHitData.set('count', Std.int(twnCount.value));

			},
			onComplete: () -> {
				scoreHitTxt.text = '0';
				scoreHitData.set('count', 0);
			}
		});

		twnScore = FlxTween.num(scoreHitData.get('score'), game.songScore, twnSecNum, {
			ease: FlxEase.circOut,
			onUpdate: () -> {
				game.scoreTxt.text = getScoreTxt(Std.int(twnScore.value));
				scoreHitData.set('score', Std.int(twnScore.value));
			},
			onComplete: () -> {
				game.scoreTxt.text = getScoreTxt(game.songScore);
				scoreHitData.set('score', game.songScore);
			}
		});
	}

	for (rating in game.ratingsData) scoreHitData.set(rating.name, 0);
	scoreHitData.set('miss', 0);
	scoreHitData.set('misses', 0);

	index = 0;
	for (obj in [comboGlow, comboHitTxt, scoreHitTxt]) {
		if (twnArray[index] != null && twnArray[index].active) twnArray[index].cancel();
		twnArray[index] = FlxTween.tween(obj, {alpha: 0}, 1.0 + (Conductor.crochet / 1000), {ease: FlxEase.cubeInOut});
	
		index++;
	}

	FlxFlicker.flicker(comboHitTxt, 0, 0.05);
}