package deltaprevention;

import lime.utils.Assets;
import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.FlxState;

class IntroState extends FlxState
{
	var track:FlxSound;

	override function create()
	{
		super.create();

		Assets.loadLibrary('intro');

		track = new FlxSound().load('intro:fa1|-Angel.ogg');
		FlxG.sound.list.add(track);

		track.play();
	}
}
