import flixel.effects.FlxFlicker;
import flixel.group.FlxTypedSpriteGroup;
import cutscenes.CutsceneHandler;
import psychlua.LuaUtils;

var cutscene:CutsceneHandler;
var cutsceneInit:Bool = false;
var cutsceneStart:Bool = false;

var cutsceneGroup:FlxTypedSpriteGroup<Dynamic>;

var nikku_b:FlxSprite;
var nikku_h:FlxSprite;
var dialog_box:FlxSprite;
var sans_text:FlxSprite;
var buttons:FlxSprite;
var toby_dog:FlxSprite;
var flash:FlxSprite;

var twnArray:Array<FlxTween> = [];

function onCreate() {
    cutsceneGroup = new FlxTypedSpriteGroup();
    cutsceneGroup.cameras = [getVar('camCutscene')];

    for (i in 0...9) twnArray.push(var twn:FlxTween = null);

    nikku_b = new FlxSprite().loadGraphic(Paths.image('stages/hallway/cutscene/1'));
    cutsceneGroup.add(nikku_b);

    nikku_h = new FlxSprite().loadGraphic(Paths.image('stages/hallway/cutscene/2'));
    cutsceneGroup.add(nikku_h);

    dialog_box = new FlxSprite().loadGraphic(Paths.image('stages/hallway/cutscene/3'));
    cutsceneGroup.add(dialog_box);

    sans_text = new FlxSprite().loadGraphic(Paths.image('stages/hallway/cutscene/4'));
    cutsceneGroup.add(sans_text);

    buttons = new FlxSprite().loadGraphic(Paths.image('stages/hallway/cutscene/5'));
    cutsceneGroup.add(buttons);

    toby_dog = new FlxSprite();
    toby_dog.frames = Paths.getSparrowAtlas('stages/hallway/cutscene/6');
    toby_dog.animation.addByPrefix('idle', 'Toby Dog', 5, true);
    cutsceneGroup.add(toby_dog);

    flash = new FlxSprite().makeGraphic(1, 1, FlxColor.WHITE);
    flash.scale.set(FlxG.width, FlxG.height);
    flash.screenCenter();
    if (ClientPrefs.data.flashing) cutsceneGroup.add(flash);

    return;
}

var twn:FlxTween = null;
var twn_alpha:FlxTween = null;
function onEvent(name, value1, value2) {
    if (name == 'Fandomania Cutscene Flash') {
        resetAnimation();

        FlxG.camera.alpha = 0;

        flash.alpha = 1;

        if (twn_alpha != null && twn_alpha.active) twn_alpha.cancel();
        twn_alpha = FlxTween.tween(game.camHUD, {alpha: 0}, (Conductor.crochet / 1000) * 2, {ease: FlxEase.quartOut});

        if (twn != null && twn.active) twn.cancel();
        twn = FlxTween.tween(flash, {alpha: 0}, (Conductor.crochet / 1000));

        add(cutsceneGroup);

        cutsceneInit = true;
        cutsceneStart = true;
    }

    if (name == 'Fandomania Cutscene Start') {
        if (!cutsceneInit) return;

        if (!cutsceneStart) resetAnimation();

        cutscene = new CutsceneHandler();

        cutsceneStart = false;
        
        cutscene.endTime = 7.5;

        cutscene.onStart = function() {
            nikku_b.alpha = nikku_h.alpha = 0;

            twnArray[0] = FlxTween.num(-5, 5, (Conductor.crochet / 1000) * 1.5, {
                type: LuaUtils.getTweenTypeByString('pingpong'),
                onUpdate: () -> {
                    nikku_b.y = nikku_h.y = ((FlxG.height - nikku_b.height) / 2) + twnArray[0].value;
        
                    nikku_b.offset.y = twnArray[0].value * 1.35;
                    nikku_h.offset.y = twnArray[0].value * 1.15;
                }
            });
        
            twnArray[1] = FlxTween.tween(nikku_b, {alpha: 1}, 5, {startDelay: 0.2});
            twnArray[2] = FlxTween.tween(nikku_h, {alpha: 1}, 5, {startDelay: 0.2});

            twnArray[3] = FlxTween.tween(nikku_b.scale, {x: 3, y: 3}, 8);
            twnArray[4] = FlxTween.tween(nikku_h.scale, {x: 3, y: 3}, 8);

            twnArray[5] = FlxTween.tween(dialog_box.offset, {y: -560}, 1.5, {
                onUpdate: () -> {
                    sans_text.offset.y = dialog_box.offset.y;
                }
            });
            
            twnArray[6] = FlxTween.tween(dialog_box, {angle: -25}, 3, {
                onUpdate: () -> {
                    sans_text.angle = dialog_box.angle;
                }
            });

            twnArray[7] = FlxTween.tween(buttons.offset, {y: -450}, 1);
            twnArray[8] = FlxTween.tween(buttons, {angle: 25}, 2);

            nikku_b.visible = nikku_h.visible = true;
        };

        cutscene.timer(0.45, function() {
            sans_text.visible = false;
            dialog_box.scale.x = 0.5;
        });

        cutscene.timer(0.5, function() {
            dialog_box.scale.x = 0;
        });
    
        cutscene.timer(5.18, function() {
            FlxFlicker.flicker(nikku_b, (Conductor.crochet / 1000), (Conductor.crochet / 1000) / 2, false);
            FlxFlicker.flicker(nikku_h, (Conductor.crochet / 1000), (Conductor.crochet / 1000) / 2, false, true, () -> {
                toby_dog.animation.play('idle', true);
                toby_dog.visible = true;
            });
        });

        cutscene.timer(7.2, function() {
            if (FlxFlicker.isFlickering(toby_dog)) FlxFlicker.stopFlickering(toby_dog);

            FlxFlicker.flicker(toby_dog, (Conductor.crochet / 1000), (Conductor.stepCrochet / 1000) / 2);
        });

        cutscene.finishCallback = function() {		 
            cutsceneInit = false;

            FlxG.camera.alpha = 1;
            game.camHUD.alpha = 1;

            remove(cutsceneGroup);

            for (twn in twnArray) {
                if (twn != null && twn.active) {
                    twn.cancel();
                    twn = null;
                }
            }
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

    if (FlxFlicker.isFlickering(nikku_b)) FlxFlicker.stopFlickering(nikku_b);
    if (FlxFlicker.isFlickering(nikku_h)) FlxFlicker.stopFlickering(nikku_h);

    nikku_b.scale.set(2, 2);
    nikku_b.updateHitbox();
    nikku_b.screenCenter(0x01);
    nikku_b.visible = false;

    nikku_h.scale.set(2, 2);
    nikku_h.updateHitbox();
    nikku_h.screenCenter(0x01);
    nikku_h.visible = false;

    dialog_box.scale.set(3, 3);
    dialog_box.updateHitbox();
    dialog_box.screenCenter();
    dialog_box.angle = 0;

    sans_text.scale.set(3, 3);
    sans_text.updateHitbox();
    sans_text.screenCenter();
    sans_text.visible = true;
    sans_text.angle = 0;

    buttons.scale.set(2.2, 2.2);
    buttons.updateHitbox();
    buttons.screenCenter();
    buttons.angle = 0;
    buttons.y += 250;

    toby_dog.scale.set(5, 5);
    toby_dog.updateHitbox();
    toby_dog.screenCenter(0x01);
    toby_dog.visible = false;
}