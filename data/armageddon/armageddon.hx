function onCreatePost() {
    var dadPos:Int = FlxG.state.members.indexOf(game.dadGroup);
    var bfPos:Int = FlxG.state.members.indexOf(game.boyfriendGroup);
    if (dadPos > bfPos) return;

    FlxG.state.members[bfPos] = game.dadGroup;
    FlxG.state.members[dadPos] = game.boyfriendGroup;

    return;
}