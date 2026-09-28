package deltaprevention.objects;

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
}
