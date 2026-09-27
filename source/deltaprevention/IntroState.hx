package deltaprevention;

import flixel.util.FlxSpriteUtil;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.group.FlxSpriteContainer;
import lime.utils.Assets;
import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.FlxState;

class IntroState extends FlxState
{
	var track:FlxSound;

	var deltas:FlxSpriteContainer;
	var deltaTimers:Array<Float> = [];

	var deltaTimerSpeed:Float = 1.0;
	var deltaXSpeed:Float = 1.0;
	var deltaYSpeed:Float = 1.0;

	var starWars:FlxText;
	var rune = [
		'ON THE DAY',
		'WHERE THE DELTAS MERGE INTO',
		'THE DELTA CRYSTAL',
		'',
		'THE LOTA WILL EMERGE',
		'AND BRING',
		'',
		'THE CHAOS',
		'',
		'STRESSING THE WORLD',
		'WITH HEAT FROM THE DELTA FURNACE',
		'',
		'MELTING IT',
		'TO BE MOLDED',
		'INTO THE DELTA EARTH',
		'',
		'THE ONLY WAY FOR THIS TO NOT HAPPEN',
		'IS TO SEAL THE FURNACES OF THE DELTA REALMS',
	];

	var fade:Fade;

	var deltaCrystal:FlxSprite;
	var deltaCrystalBoom:FlxSprite;
	var melting:Fade;

	override function create()
	{
		super.create();

		Assets.loadLibrary('intro');

		Save.instance.seenIntro = true;

		add(starWars = new FlxText(0, 0, FlxG.width, rune.join('\n'), 32));
		starWars.alignment = CENTER;
		starWars.y = FlxG.height;
		starWars.color = 0xFFFFFFFF;

		add(fade = new Fade());
		fade.color = 0xFF000000;
		fade.screenCenter(X);
		fade.flipY = true;

		add(deltas = new FlxSpriteContainer());

		add(deltaCrystal = new FlxSprite().loadGraphic('deltacrystal.png'));
		deltaCrystal.alpha = 0.001;
		deltaCrystal.screenCenter();

		add(deltaCrystalBoom = new FlxSprite().loadGraphic('explosionOutline.png'));
		deltaCrystalBoom.setGraphicSize(10);
		deltaCrystalBoom.updateHitbox();
		deltaCrystalBoom.alpha = 0.001;
		deltaCrystalBoom.screenCenter();

		add(melting = new Fade());
		melting.alpha = 0.001;
		melting.screenCenter(X);
		melting.color = 0xFF6600;

		track = new FlxSound().load('intro:fa1l-Angel.ogg');
		FlxG.sound.list.add(track);

		track.play();

		FlxTween.tween(starWars, {y: -starWars.height}, 60);

		new FlxTimer().start(1.43, t ->
		{
			if (t.loopsLeft == 8) t.time = 0.71;
			spawnDelta();
		}, 9);

		FlxTimer.wait(12.86, beginTheChaos);

		FlxTimer.wait(70, beginToEnd);
	}

	function spawnDelta()
	{
		var delta = new FlxSprite().loadRotatedGraphic('delta.png', 16,);
		delta.ID = deltas.length;
		delta.animation.frameIndex = FlxG.random.int(0, delta.animation.numFrames - 1);
		deltas.add(delta);
		deltaTimers.push(0.0);

		delta.screenCenter();

		delta.alpha = 0.001;

		FlxTween.tween(delta, {alpha: 1}, 1, {
			ease: FlxEase.quintOut,
		});
	}

	function beginTheChaos()
	{
		var flashColor = 0xFF066600;

		FlxTween.tween(this, {
			deltaTimerSpeed: 50,
			deltaXSpeed: 0.0001,
			deltaYSpeed: 0.0001,
		}, 12, {
			ease: FlxEase.backIn,
			onUpdate: t ->
			{
				for (delta in deltas) if (FlxG.random.bool(deltaTimerSpeed))
				{
					FlxSpriteUtil.flashTint(delta, flashColor, 0.25);
					(delta.animation.frameIndex + 1 >= delta.animation.numFrames) ? 0 : delta.animation.frameIndex += 1;
				}
			},
		});

		deltaCrystalBoom.color = flashColor;
		deltaCrystalBoom.alpha = 0.0001;

		FlxTimer.wait(12, () ->
		{
			deltas.visible = false;

			deltaCrystal.alpha = 1;
			FlxSpriteUtil.flashTint(deltaCrystal, flashColor, 0.5);
		});

		FlxTween.num(10, FlxG.width, 0.5, {
			startDelay: 12,
		}, t ->
		{
			deltaCrystalBoom.setGraphicSize(t);
			deltaCrystalBoom.alpha = 1 - (t / FlxG.width);
		});

		FlxTween.tween(melting, {alpha: 1}, 15, {
			startDelay: 12,
			ease: FlxEase.cubeIn
		});
	}

	function beginToEnd()
	{
		track.fadeOut(5, 0, t ->
		{
			FlxG.switchState(() -> new FlxState());
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (deltas.visible) for (delta in deltas)
		{
			if (delta.alpha < 1) continue;

			deltaTimers[delta.ID] += elapsed * deltaTimerSpeed;

			delta.screenCenter();
			delta.x += ((Math.sin(deltaTimers[delta.ID]) * 100) * deltaXSpeed);
			delta.y += (((Math.cos(deltaTimers[delta.ID]) * 60) - delta.height * 7.65) * deltaYSpeed);
		}
	}

	override function onFocusLost()
	{
		super.onFocusLost();

		track.pause();
	}

	override function onFocus()
	{
		super.onFocus();

		track.resume();
	}
}
