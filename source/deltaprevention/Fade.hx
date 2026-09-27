package deltaprevention;

import flixel.FlxG;
import flixel.FlxSprite;

class Fade extends FlxSprite
{
	public function new(?width:Null<Float>, ?height:Null<Float>)
	{
		super();

		loadGraphic('fade.png');
		resize(width, height);
	}

	public function resize(?width:Null<Float>, ?height:Null<Float>)
	{
		scale.set(width ?? FlxG.width, height ?? 1);
		updateHitbox();
	}
}
