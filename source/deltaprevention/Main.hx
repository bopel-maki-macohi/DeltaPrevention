package deltaprevention;

import lime.utils.Assets;
import deltaprevention.chapters.Chapter1;
import flixel.FlxG;
import openfl.events.Event;
import flixel.FlxGame;

class Main extends FlxGame
{
	public function new()
	{
		super(0, 0, null);
	}

	override function create(_:Event)
	{
		Save.instance = new Save();
		Language.instance = new Language();

		super.create(_);

		if (Save.instance.seenIntro) FlxG.switchState(() -> new Chapter1());
		else FlxG.switchState(() -> new IntroState());
	}

	override function switchState()
	{
		// @:privateAccess
		// for (library => lib in Assets.libraries) if (library != 'default') Assets.unloadLibrary(library);

		super.switchState();
	}
}
