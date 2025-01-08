import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import flixel.group.FlxTypedSpriteGroup;
import cutscenes.CutsceneHandler;
import psychlua.LuaUtils;

var dir:String = 'stages/skatepark/cutscene/';

var cutscene:CutsceneHandler;
var cutsceneInit:Bool = false;

var cutsceneGroup:FlxTypedSpriteGroup<Dynamic>;

var twnArray:Array<FlxTween> = [];

var bg:FlxBackdrop;
var floor:FlxBackdrop;
var exe:FlxSprite;
var nikku:FlxSprite;
var plants:FlxBackdrop;
var flash:FlxSprite;
var col:FlxSprite;

function onCreate() {
    cutsceneGroup = new FlxTypedSpriteGroup();
    cutsceneGroup.cameras = [getVar('camCutscene')];

    bg = new FlxBackdrop(Paths.image(dir + 'background'), 0x01);
    bg.scale.set(3, 3);
    bg.updateHitbox();
    bg.screenCenter();
    bg.velocity.x = -750 * game.playbackRate;
    cutsceneGroup.add(bg);

    floor = new FlxBackdrop(Paths.image(dir + 'ground'), 0x01);
    floor.scale.set(bg.scale.x, bg.scale.y);
    floor.updateHitbox();
    floor.screenCenter();
    floor.velocity.x = bg.velocity.x * 1.5;
    floor.y += bg.height / 3 + 10;
    cutsceneGroup.add(floor);

    exe = new FlxSprite().loadGraphic(Paths.image(dir + 'exe'));
    exe.scale.set(5, 5);
    exe.updateHitbox();
    exe.screenCenter(0x10);
    cutsceneGroup.add(exe);

    nikku = new FlxSprite().loadGraphic(Paths.image(dir + 'nikku'));
    nikku.scale.set(4, 4);
    nikku.updateHitbox();
    nikku.screenCenter();
    cutsceneGroup.add(nikku);

    plants = new FlxBackdrop(Paths.image(dir + 'leaves'), 0x01);
    plants.scale.set(floor.scale.x * 2, floor.scale.y * 2);
    plants.updateHitbox();
    plants.screenCenter();
    plants.velocity.x = floor.velocity.x * 2;
    plants.y += floor.y - 120;
    cutsceneGroup.add(plants);

    flash = new FlxSprite().makeGraphic(1, 1);
    flash.scale.set(FlxG.width, FlxG.height);
    flash.updateHitbox();
    flash.screenCenter(0x10);
    flash.color = FlxColor.BLACK;
    if (ClientPrefs.data.flashing) cutsceneGroup.add(flash);

    col = new FlxSprite().makeGraphic(1, 1);
    col.scale.set(FlxG.width, FlxG.height);
    col.updateHitbox();
    col.screenCenter(0x10);
    col.color = FlxColor.BLACK;
    cutsceneGroup.add(col);
    
    return;
}

function onEvent(name, value1, value2) {
    if (name == 'Sonic.EXE Cutscene') {
        resetAnimation();

        cutscene = new CutsceneHandler();
        
        cutscene.endTime = 6.5 / game.playbackRate;

        cutscene.onStart = function() {
            FlxG.camera.visible = false;
            game.camHUD.visible = false;

            add(cutsceneGroup);

            FlxFlicker.flicker(flash, 0.001, 0.0001, false);

            twnArray[0] = FlxTween.tween(col, {alpha: 0}, 0.2 / game.playbackRate);

            twnArray[1] = FlxTween.tween(exe, {x: nikku.x}, 8 / game.playbackRate);

            twnArray[2] = FlxTween.tween(exe, {y: exe.y - 10}, 0.16 / game.playbackRate, {
                ease: FlxEase.smoothStepInOut,
                type: LuaUtils.getTweenTypeByString('pingpong'),
                onUpdate: () -> {
                    nikku.y = exe.y - 50;
                }
            });

        };

        cutscene.timer(6.3 / game.playbackRate, function() {
            FlxFlicker.flicker(flash, 0.5 / game.playbackRate, 0.04 / game.playbackRate);
        });

        cutscene.finishCallback = function() {		 
            FlxG.camera.visible = true;
            game.camHUD.visible = true;

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

    exe.screenCenter(0x10);
    exe.x = -exe.width;
    exe.y -= 30;

    col.alpha = 1;
}