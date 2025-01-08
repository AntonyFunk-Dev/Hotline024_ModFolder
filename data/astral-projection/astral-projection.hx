var oppStrums:Bool = ClientPrefs.data.opponentStrums;
var middScroll:Bool = ClientPrefs.data.middleScroll;

ClientPrefs.data.opponentStrums = false;
ClientPrefs.data.middleScroll = false;

function onCreatePost() {
	for (i in 0...4) game.playerStrums.members[i].x = 115 + i * 150 + (i >= 2 ? 490 : 0);

	for (icon in [game.iconP1, game.iconP2]) icon.kill();
	game.healthBar.kill();

	return;
}

function onDestroy() {
	ClientPrefs.data.opponentStrums = oppStrums;
	ClientPrefs.data.middleScroll = middScroll;

	return;
}