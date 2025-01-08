import flixel.effects.FlxFlicker;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxTypedSpriteGroup;
import cutscenes.CutsceneHandler;
import psychlua.ModchartSprite;
import psychlua.LuaUtils;

var cutscene:CutsceneHandler;
var cutsceneInit:Bool = false;

var cutsceneGroup:FlxTypedSpriteGroup<Dynamic>;

var twnArray:Array<FlxTween> = [];

var grid_overlay:FlxBackdrop;
var numbah_eigth_1:FlxBackdrop;
var numbah_eigth_2:FlxBackdrop;
var nikku:FlxSprite;
var textbox:FlxSprite;
var text:FlxSprite;
var octagon:FlxSprite;
var hereletme:FlxSprite;
var showyou:FlxSprite;
var flash:FlxSprite;
var col:FlxSprite;

function onCreate() {
    cutsceneGroup = new FlxTypedSpriteGroup();
    cutsceneGroup.cameras = [getVar('camCutscene')];

    grid_overlay = new FlxBackdrop(FlxGridOverlay.createGrid(FlxG.width, FlxG.height / 3, FlxG.width, FlxG.height + (FlxG.height / 3), true, 0xFFFFFFFF, 0xFFFF8D31));
    grid_overlay.antialiasing = ClientPrefs.data.antialiasing;
    cutsceneGroup.add(grid_overlay);

    var spr = new FlxSprite().loadGraphic(Paths.image('stages/skatepark/octagon/numbah_eight'));

    numbah_eigth_1 = new FlxBackdrop(spr.graphic, 0x11, 0, spr.height);
    numbah_eigth_1.antialiasing = ClientPrefs.data.antialiasing;
    numbah_eigth_1.screenCenter();
    numbah_eigth_1.velocity.x = 150;
    cutsceneGroup.add(numbah_eigth_1);

    numbah_eigth_2 = new FlxBackdrop(spr.graphic, 0x11, 0, spr.height);
    numbah_eigth_2.antialiasing = ClientPrefs.data.antialiasing;
    numbah_eigth_2.screenCenter();
    numbah_eigth_2.velocity.x = numbah_eigth_1.velocity.x * -1;
    numbah_eigth_2.y += spr.height;
    cutsceneGroup.add(numbah_eigth_2);

    nikku = new ModchartSprite();
    nikku.frames = Paths.getSparrowAtlas('stages/skatepark/octagon/nikku');
    nikku.animation.addByPrefix('idle', 'Nikku Last Frame', 1, false);
    nikku.animation.addByPrefix('move', 'Nikku Move 1', 24, true);
    nikku.antialiasing = ClientPrefs.data.antialiasing;
    nikku.addOffset('idle', 0, 0);
    nikku.addOffset('move', 360, 345);
    cutsceneGroup.add(nikku);

    textbox = new FlxSprite().loadGraphic(Paths.image('stages/skatepark/octagon/textbox'));
    textbox.antialiasing = ClientPrefs.data.antialiasing;
    textbox.origin.set(0, textbox.height);
    cutsceneGroup.add(textbox);

    text = new FlxSprite();
    text.frames = Paths.getSparrowAtlas('stages/skatepark/octagon/text');
    text.animation.addByPrefix('text', 'Text', 24, false);
    text.antialiasing = ClientPrefs.data.antialiasing;
    text.scale.set(0.6, 0.6);
    text.updateHitbox();
    text.screenCenter();
    text.x += 160;
    text.y -= 50;
    cutsceneGroup.add(text);

    octagon = new FlxSprite().loadGraphic(Paths.image('stages/skatepark/octagon/octagon'));
    octagon.antialiasing = ClientPrefs.data.antialiasing;
    octagon.scale.set(0.7, 0.7);
    octagon.updateHitbox();
    octagon.screenCenter(0x10);
    octagon.y += 80;
    cutsceneGroup.add(octagon);

    hereletme = new FlxSprite().loadGraphic(Paths.image('stages/skatepark/octagon/hereletme'));
    hereletme.antialiasing = ClientPrefs.data.antialiasing;
    hereletme.scale.set(0.7, 0.7);
    hereletme.updateHitbox();
    hereletme.x = ((FlxG.width / 3) - hereletme.width) / 2;
    cutsceneGroup.add(hereletme);

    showyou = new FlxSprite().loadGraphic(Paths.image('stages/skatepark/octagon/showyou'));
    showyou.antialiasing = ClientPrefs.data.antialiasing;
    showyou.scale.set(0.7, 0.7);
    showyou.updateHitbox();
    showyou.x = FlxG.width - (((FlxG.width / 3) + showyou.width) / 2);
    cutsceneGroup.add(showyou);

    flash = new FlxSprite().makeGraphic(1, 1);
    flash.scale.set(FlxG.width, FlxG.height);
    flash.updateHitbox();
    flash.screenCenter(0x10);
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
    if (name == 'Sugarcrush Octagon Cutscene') {  
        resetAnimation();

        cutscene = new CutsceneHandler();
        
        cutscene.endTime = 13.2;

        cutscene.onStart = function() {
            FlxG.camera.visible = false;

            add(cutsceneGroup);

            FlxFlicker.flicker(flash, 0.001, 0.0001, false);

            twnArray[0] = FlxTween.tween(col, {alpha: 0}, 0.2);

            twnArray[1] = FlxTween.tween(nikku, {x: 210, y: 265}, 0.2);

            nikku.playAnim('move', true);
        };

        cutscene.timer(0.15, function() {
            twnArray[2] = FlxTween.tween(textbox.scale, {x: 1.28, y: 1.28}, 0.2, {
                onComplete: () -> {
                    text.alpha = 1;
                }
            });

            text.animation.play('text', true);

            textbox.alpha = 1;
        });

        cutscene.timer(4, function() {
            twnArray[3] = FlxTween.tween(octagon, {x: octagon.x - 360}, 0.1);

            octagon.alpha = 1;
        });

        cutscene.timer(11.5, function() {
            twnArray[4] = FlxTween.tween(nikku, {x: 500}, 0.2, {
                onComplete: () -> {
                    nikku.playAnim('idle', true);

                    twnArray[4] = FlxTween.tween(nikku.scale, {x: 1.8, y: 1.8}, 2);
                }
            });

            twnArray[5] = FlxTween.tween(octagon, {x: FlxG.width}, 0.1);

            twnArray[6] = FlxTween.tween(hereletme, {y: (FlxG.height - hereletme.height) / 2}, 0.3);
            twnArray[7] = FlxTween.tween(showyou, {y: (FlxG.height - showyou.height) / 2}, 0.3);

            textbox.alpha = 0;
            text.alpha = 0;

            hereletme.alpha = 1;
            showyou.alpha = 1;
        });

        cutscene.timer(12.5, function() {
            FlxFlicker.flicker(flash, 0.85, 0.05);
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

    nikku.scale.set(1.7, 1.7);
    nikku.updateHitbox();
    nikku.x = -nikku.width;
    nikku.y = FlxG.height;
    
    octagon.x = FlxG.width;
    octagon.alpha = 0;

    textbox.screenCenter(0x10);
    textbox.x = (FlxG.width / 2) - 145;
    textbox.y -= 30;
    textbox.scale.set(0.5, 0.5);
    textbox.alpha = 0;

    text.alpha = 0;

    hereletme.y = FlxG.height;
    hereletme.alpha = 0;

    showyou.y = FlxG.height;
    showyou.alpha = 0;

    col.alpha = 1;
}