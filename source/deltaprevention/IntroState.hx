package deltaprevention;

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

	override function create()
	{
		super.create();

		Assets.loadLibrary('intro');

		add(deltas = new FlxSpriteContainer());

		track = new FlxSound().load('intro:fa1l-Angel.ogg');
		FlxG.sound.list.add(track);

		track.play();

		new FlxTimer().start(1.43, t ->
		{
			if (t.loopsLeft == 8) t.time = 0.71;
			spawnDelta();
		}, 9);
		// FlxTimer.wait(2.14, spawnDelta);
		// FlxTimer.wait(2.86, spawnDelta);
		// FlxTimer.wait(3.57, spawnDelta);
		// FlxTimer.wait(3.57, spawnDelta);
		// FlxTimer.wait(4.28, spawnDelta);
		// FlxTimer.wait(5, spawnDelta);
		// FlxTimer.wait(6.43, spawnDelta);
		// FlxTimer.wait(7.14, spawnDelta);
	}

	function spawnDelta()
	{
		var delta = new FlxSprite().loadRotatedGraphic('delta.png', 16,);
		delta.ID = deltas.length;
		delta.animation.frameIndex = FlxG.random.int(0, delta.animation.numFrames - 1);
		deltas.add(delta);
		deltaTimers.push(0.0);

		delta.screenCenter();

		delta.alpha = 0;

		FlxTween.tween(delta, {alpha: 1}, 1, {
			ease: FlxEase.quintOut,
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		for (delta in deltas)
		{
			if (delta.alpha < 1) continue;

			deltaTimers[delta.ID] += elapsed;

			delta.x = ((FlxG.width - delta.width) / 2) + (Math.sin(deltaTimers[delta.ID]) * 100);
			delta.y = ((FlxG.height - delta.height) / 2) + (Math.cos(deltaTimers[delta.ID]) * 60) - delta.height * 7.65;
		}
	}
}
