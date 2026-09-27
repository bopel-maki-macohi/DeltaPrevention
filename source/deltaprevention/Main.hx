package deltaprevention;

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

		super.create(_);

		FlxG.switchState(() -> new IntroState());
	}
}
