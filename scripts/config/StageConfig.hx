import tjson.TJSON as Json;

var stageData:Dynamic = Json.parse(File.getContent(Paths.modFolders(getVar('stageConfigJson'))));

var isCameraOnForcedPos:Bool = false;

var stage:Array<Dynamic> = [
	stageData.boyfriend,
	stageData.opponent,
	stageData.girlfriend
];

var cam:Array<Dynamic> = [
	stage[0].camera,
	stage[1].camera,
	stage[2].camera
];

var charConfig:Bool = false;
var reflectConfig:Bool = false;

setVar('stageData', stageData);

for (obj in stage) {
	if (stage.indexOf(obj) == null) continue;

	if (obj.scale != null || obj.scrollFactor != null || obj.order != null)
	charConfig = true;

	if (obj.reflect != null)
	reflectConfig = true;
}

if (charConfig) game.startHScriptsNamed('scripts/config/CharStageConfig.hx');

function onCreatePost() {
	if (cam[2].pos_locked != null && cam[2].pos_locked.length > 0) {
		FlxG.camera.scroll.x = (cam[2].pos_locked[0] != null ? cam[2].pos_locked[0] : 0) - FlxG.camera.width / 2;
		FlxG.camera.scroll.y = (cam[2].pos_locked[1] != null ? cam[2].pos_locked[1] : 0) - FlxG.camera.height / 2;
	}

	return;
}

function onUpdatePost() {
	if (isCameraOnForcedPos || game.isDead) return;

	if (game.gf != null && gfSection) {
		if (cam[2].zoom != null) game.defaultCamZoom = cam[2].zoom;

		if (game.gf.getAnimationName().indexOf('sing') == -1)
		FlxG.camera.targetOffset.set(0, 0);

		return setMoveCamera(2);
	}

	if (!mustHitSection) {
		if (cam[1].zoom != null) game.defaultCamZoom = cam[1].zoom;

		if (game.dad.getAnimationName().indexOf('sing') == -1)
		FlxG.camera.targetOffset.set(0, 0);

		setMoveCamera(1);
	} else {
		if (cam[0].zoom != null) game.defaultCamZoom = cam[0].zoom;

		if (game.boyfriend.getAnimationName().indexOf('sing') == -1)
		FlxG.camera.targetOffset.set(0, 0);

		setMoveCamera();
	}

	return;
}

function goodNoteHit(note) {
	if (note.noteType == 'No Animation' || note.noteType == 'Hurt Note') return;

	if (mustHitSection) {
		if (game.gf != null && gfSection) return moveOffsetCamera(2, note);
		
		if (!gfSection) moveOffsetCamera(0, note);
	}

	return;
}

function opponentNoteHit(note) {
	if (note.noteType == 'No Animation' || note.noteType == 'Hurt Note') return;

	if (!mustHitSection) {
		if (game.gf != null && gfSection) return moveOffsetCamera(2, note);

		if (!gfSection) moveOffsetCamera(1, note);
	}

	return;
}

function onEvent(name, value1, value2) {
	if (name == 'Camera Follow Pos') {
		isCameraOnForcedPos = (value1 != '' ? true : false);
	}

	return;
}

function setMoveCamera(?charType:Int = 0) {
	if (cam[charType].pos_locked != null && cam[charType].pos_locked.length > 0) {
		game.camFollow.x = cam[charType].pos_locked[0] != null ? cam[charType].pos_locked[0] : 0;
		game.camFollow.y = cam[charType].pos_locked[1] != null ? cam[charType].pos_locked[1] : 0;
	} else {
		switch(charType) {
			case 2:
				game.camFollow.setPosition(game.gf.getMidpoint().x, game.gf.getMidpoint().y);
				game.camFollow.x += game.gf.cameraPosition[0] + game.girlfriendCameraOffset[0];
				game.camFollow.y += game.gf.cameraPosition[1] + game.girlfriendCameraOffset[1];
			case 1:
				game.camFollow.setPosition(game.dad.getMidpoint().x + 150, game.dad.getMidpoint().y - 100);
				game.camFollow.x += game.dad.cameraPosition[0] + game.opponentCameraOffset[0];
				game.camFollow.y += game.dad.cameraPosition[1] + game.opponentCameraOffset[1];
			default:
				game.camFollow.setPosition(game.boyfriend.getMidpoint().x - 100, game.boyfriend.getMidpoint().y - 100);
				game.camFollow.x -= game.boyfriend.cameraPosition[0] - game.boyfriendCameraOffset[0];
				game.camFollow.y += game.boyfriend.cameraPosition[1] + game.boyfriendCameraOffset[1];
		}
	}
}

function moveOffsetCamera(?charType:Int = 0, ?note:Note = null) {
	if (charType != 2 && note.noteType == 'GF Sing') return;
	
	FlxG.camera.targetOffset.x = (note.noteData == 0 ? -(cam[charType].target_offset != null ? cam[charType].target_offset : 0)
	: (note.noteData == 3 ? (cam[charType].target_offset != null ? cam[charType].target_offset : 0) : 0));
	FlxG.camera.targetOffset.y = (note.noteData == 1 ? (cam[charType].target_offset != null ? cam[charType].target_offset : 0)
	: (note.noteData == 2 ? -(cam[charType].target_offset != null ? cam[charType].target_offset : 0) : 0));
}