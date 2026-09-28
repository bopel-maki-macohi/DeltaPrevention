package deltaprevention.objects;

import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.FlxSprite;

class Character extends FlxSprite
{
	public function new(path:String, fw:Int, fh:Int, anims:Map<String, Dynamic>)
	{
		super();

		loadGraphic('chapters/characters/$path.png', true, fw, fh);

		for (name => data in anims)
		{
			var frames:Array<Int> = data.frames;
			animation.add(name, frames ?? [], data?.fps ?? 24, data?.looped ?? false);
		}
	}

	public function play(anim:String) animation.play(anim);

	public function shake(amount:Float, time:Float, snappyAmount:Float = 0)
	{
		if (amount == 0) return;
		if (time <= 0) return;

		var offsetsApplied = 0.0;

		FlxTween.num(0, 1, time, {}, t ->
		{
			if (FlxG.random.bool(100 - snappyAmount))
			{
				var amount = FlxG.random.float(-amount, amount);
				offsetsApplied += amount;
				offset.add(amount);
			}
		});

		offset.subtract(offsetsApplied);
	}
}
