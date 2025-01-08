var delay:Float = 0;
var offsetX:Float = 0;
function onSpawnNote(note) {
	if (note.noteType != 'Swap Note') return;

	delay = (note.strumTime - Conductor.songPosition - ((note.isSustainNote ? 1300 : 1200) / (game.songSpeed / game.playbackRate))) / 1000;
	offsetX = note.offsetX;

	note.offsetX += (note.mustPress ? game.opponentStrums : game.playerStrums).members[note.noteData].x 
	- (note.mustPress ? game.playerStrums : game.opponentStrums).members[note.noteData].x;

	FlxTween.tween(note, {offsetX: offsetX}, Math.max(0.1, delay * 0.2) / game.playbackRate, {
		ease: FlxEase.quartOut,
		startDelay: delay / game.playbackRate
	});
}