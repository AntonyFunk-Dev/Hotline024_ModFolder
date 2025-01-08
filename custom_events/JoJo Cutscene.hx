import flixel.effects.FlxFlicker;
import flixel.group.FlxTypedSpriteGroup;
import cutscenes.CutsceneHandler;

var dir:String = 'stages/jojo/cutscene/';

var cutscene:CutsceneHandler;
var cutsceneInit:Bool = false;

var cutsceneGroup:FlxTypedSpriteGroup<Dynamic>;

var twnArray:Array<FlxTween> = [];

var bg:FlxSprite;
var bf_jojo:FlxSprite;
var bg_1:FlxSprite;
var gf_jojo:FlxSprite;
var nikku_jojo_rect:FlxSprite;
var bf_jojo_rect:FlxSprite;
var blue_red:FlxSprite;
var bf_jojo_hand:FlxSprite;
var nikku_jojo_hand:FlxSprite;
var bg_2:FlxSprite;
var bf_jojo_1:FlxSprite;
var nikku_jojo_1:FlxSprite;
var flash:FlxSprite;

function onCreate() {
    cutsceneGroup = new FlxTypedSpriteGroup();
    cutsceneGroup.cameras = [getVar('camCutscene')];

    bg = new FlxSprite().loadGraphic(Paths.image(dir + '0'));
    bg.antialiasing = ClientPrefs.data.antialiasing;
    bg.scale.set(0.7, 0.7);
    bg.updateHitbox();
    bg.screenCenter();
    cutsceneGroup.add(bg);

    bf_jojo = new FlxSprite().loadGraphic(Paths.image(dir + '1'));
    bf_jojo.antialiasing = ClientPrefs.data.antialiasing;
    bf_jojo.scale.set(0.7, 0.7);
    bf_jojo.updateHitbox();
    bf_jojo.screenCenter();
    cutsceneGroup.add(bf_jojo);

    bg_1 = new FlxSprite().loadGraphic(Paths.image(dir + '2'));
    bg_1.antialiasing = ClientPrefs.data.antialiasing;
    bg_1.scale.set(0.7, 0.7);
    bg_1.updateHitbox();
    bg_1.screenCenter();
    bg_1.offset.x += 20;
    cutsceneGroup.add(bg_1);

    gf_jojo = new FlxSprite().loadGraphic(Paths.image(dir + '3'));
    gf_jojo.antialiasing = ClientPrefs.data.antialiasing;
    cutsceneGroup.add(gf_jojo);

    nikku_jojo_rect = new FlxSprite().loadGraphic(Paths.image(dir + '4'));
    nikku_jojo_rect.antialiasing = ClientPrefs.data.antialiasing;
    nikku_jojo_rect.scale.set(0.7, 0.7);
    nikku_jojo_rect.updateHitbox();
    nikku_jojo_rect.screenCenter(0x01);
    nikku_jojo_rect.y -= 24;
    cutsceneGroup.add(nikku_jojo_rect);

    bf_jojo_rect = new FlxSprite().loadGraphic(Paths.image(dir + '5'));
    bf_jojo_rect.antialiasing = ClientPrefs.data.antialiasing;
    bf_jojo_rect.scale.set(0.7, 0.7);
    bf_jojo_rect.updateHitbox();
    bf_jojo_rect.screenCenter(0x01);
    bf_jojo_rect.y = nikku_jojo_rect.y + nikku_jojo_rect.height;
    cutsceneGroup.add(bf_jojo_rect);

    blue_red = new FlxSprite().loadGraphic(Paths.image(dir + '6'));
    blue_red.antialiasing = ClientPrefs.data.antialiasing;
    blue_red.scale.set(0.7, 0.7);
    blue_red.updateHitbox();
    blue_red.screenCenter();
    blue_red.x -= 10;
    cutsceneGroup.add(blue_red);

    bf_jojo_hand = new FlxSprite().loadGraphic(Paths.image(dir + '7'));
    bf_jojo_hand.antialiasing = ClientPrefs.data.antialiasing;
    bf_jojo_hand.scale.set(0.7, 0.7);
    bf_jojo_hand.updateHitbox();
    bf_jojo_hand.screenCenter(0x10);
    bf_jojo_hand.x -= 48;
    cutsceneGroup.add(bf_jojo_hand);

    nikku_jojo_hand = new FlxSprite().loadGraphic(Paths.image(dir + '8'));
    nikku_jojo_hand.antialiasing = ClientPrefs.data.antialiasing;
    nikku_jojo_hand.scale.set(0.7, 0.7);
    nikku_jojo_hand.updateHitbox();
    nikku_jojo_hand.screenCenter(0x10);
    nikku_jojo_hand.x = bf_jojo_hand.x + bf_jojo_hand.width + 20;
    cutsceneGroup.add(nikku_jojo_hand);

    bg_2 = new FlxSprite().loadGraphic(Paths.image(dir + '9'));
    bg_2.antialiasing = ClientPrefs.data.antialiasing;
    bg_2.scale.set(0.7, 0.7);
    bg_2.updateHitbox();
    bg_2.screenCenter();
    bg_2.x -= 25;
    cutsceneGroup.add(bg_2);

    bf_jojo_1 = new FlxSprite().loadGraphic(Paths.image(dir + '11'));
    bf_jojo_1.antialiasing = ClientPrefs.data.antialiasing;
    bf_jojo_1.scale.set(0.7, 0.7);
    bf_jojo_1.updateHitbox();
    bf_jojo_1.x = FlxG.width - bf_jojo_1.width;
    bf_jojo_1.y += 140;
    cutsceneGroup.add(bf_jojo_1);

    nikku_jojo_1 = new FlxSprite().loadGraphic(Paths.image(dir + '10'));
    nikku_jojo_1.antialiasing = ClientPrefs.data.antialiasing;
    nikku_jojo_1.scale.set(0.7, 0.7);
    nikku_jojo_1.updateHitbox();
    nikku_jojo_1.screenCenter(0x10);
    nikku_jojo_1.x = -300;
    cutsceneGroup.add(nikku_jojo_1);

    flash = new FlxSprite().makeGraphic(1, 1);
    flash.scale.set(FlxG.width, FlxG.height);
    flash.updateHitbox();
    flash.screenCenter(0x10);
    if (ClientPrefs.data.flashing) cutsceneGroup.add(flash);

    return;
}

function onEvent(name, value1, value2) {
    if (name == 'JoJo Cutscene') {
        resetAnimation();

        cutscene = new CutsceneHandler();
        
        cutscene.endTime = 6.9 / game.playbackRate;

        cutscene.onStart = function() {
            FlxG.camera.visible = false;

            add(cutsceneGroup);

            FlxFlicker.flicker(flash, 0.35 / game.playbackRate, 0.05 / game.playbackRate, false);

            twnArray[0] = FlxTween.tween(bg.offset, {x: bg.offset.x - 60}, 3 / game.playbackRate);
            twnArray[1] = FlxTween.tween(bf_jojo.offset, {x: bf_jojo.offset.x - 100}, 2 / game.playbackRate);
        };

        cutscene.timer(1.35 / game.playbackRate, function() {
            FlxFlicker.flicker(flash, 0.35 / game.playbackRate, 0.05 / game.playbackRate, false);
        });
    
        cutscene.timer(1.5 / game.playbackRate, function() {
            twnArray[2] = FlxTween.tween(gf_jojo.scale, {x: 0.75, y: 0.75}, 2 / game.playbackRate);

            bg.visible = false;
            bf_jojo.visible = false;

            bg_1.visible = true;
            gf_jojo.visible = true;
        });

        cutscene.timer(3.15 / game.playbackRate, function() {
            FlxFlicker.flicker(flash, 0.4 / game.playbackRate, 0.05 / game.playbackRate, false);
        });

        cutscene.timer(3.4 / game.playbackRate, function() {
            twnArray[3] = FlxTween.tween(nikku_jojo_rect.offset, {x: nikku_jojo_rect.offset.x - 20}, 1 / game.playbackRate);
            twnArray[4] = FlxTween.tween(bf_jojo_rect.offset, {x: bf_jojo_rect.offset.x + 20}, 1 / game.playbackRate);

            bg_1.visible = false;
            gf_jojo.visible = false;

            nikku_jojo_rect.visible = true;
            bf_jojo_rect.visible = true;
        });

        cutscene.timer(4 / game.playbackRate, function() {
            FlxFlicker.flicker(flash, 0.4 / game.playbackRate, 0.05 / game.playbackRate, false);
        });

        cutscene.timer(4.25 / game.playbackRate, function() {
            twnArray[5] = FlxTween.tween(nikku_jojo_hand.offset, {y: nikku_jojo_hand.offset.y - 20}, 1 / game.playbackRate);
            twnArray[6] = FlxTween.tween(bf_jojo_hand.offset, {y: bf_jojo_hand.offset.y + 20}, 1 / game.playbackRate);

            nikku_jojo_rect.visible = false;
            bf_jojo_rect.visible = false;

            blue_red.visible = true;
            bf_jojo_hand.visible = true;
            nikku_jojo_hand.visible = true;
        });

        cutscene.timer(4.85 / game.playbackRate, function() {
           FlxFlicker.flicker(flash, 0.4 / game.playbackRate, 0.05 / game.playbackRate, false);
        });

        cutscene.timer(5.1 / game.playbackRate, function() {
            twnArray[7] = FlxTween.tween(nikku_jojo_1.offset, {x: nikku_jojo_1.offset.x - 20}, 2 / game.playbackRate);
            twnArray[8] = FlxTween.tween(bf_jojo_1.offset, {x: bf_jojo_1.offset.x + 20}, 2 / game.playbackRate);

            blue_red.visible = false;
            bf_jojo_hand.visible = false;
            nikku_jojo_hand.visible = false;

            bg_2.visible = true;
            bf_jojo_1.visible = true;
            nikku_jojo_1.visible = true;
        });

        cutscene.timer(6.4 / game.playbackRate, function() {
            FlxFlicker.flicker(flash, 0.6 / game.playbackRate, 0.05 / game.playbackRate);
        });

        cutscene.finishCallback = function() {		 
            FlxG.camera.visible = true;

            remove(cutsceneGroup);
        };
    }
}

function resetAnimation() {
    if (cutscene != null) {
        cutscene.destroy();
        cutscene = null;
    }

    for (twn in twnArray) {
        if (twn != null && twn.active) {
            twn.cancel();
            twn = null;
        }
    }

    if (FlxFlicker.isFlickering(flash)) FlxFlicker.stopFlickering(flash);

    bg.offset.x = 300;
    bg.visible = true;

    bf_jojo.offset.x = 40;
    bf_jojo.visible = true;

    bg_1.visible = false;

    gf_jojo.scale.set(0.7, 0.7);
    gf_jojo.updateHitbox();
    gf_jojo.screenCenter();
    gf_jojo.offset.x = 200;
    gf_jojo.visible = false;

    nikku_jojo_rect.offset.x = 340;
    nikku_jojo_rect.visible = false;

    bf_jojo_rect.offset.x = 307;
    bf_jojo_rect.visible = false;

    blue_red.visible = false;

    bf_jojo_hand.offset.y = 155;
    bf_jojo_hand.visible = false;

    nikku_jojo_hand.offset.y = 200;
    nikku_jojo_hand.visible = false;

    bg_2.visible = false;

    bf_jojo_1.offset.x = 40;
    bf_jojo_1.visible = false;

    nikku_jojo_1.offset.x = 40;
    nikku_jojo_1.visible = false;
}