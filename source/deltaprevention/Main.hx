package deltaprevention;

import flixel.system.scaleModes.FillScaleMode;
import haxe.Json;
import lime.utils.Assets;
import flixel.FlxG;
import openfl.events.Event;
import flixel.FlxGame;

class Main extends FlxGame
{
	var playing = false;

	public function new()
	{
		super(0, 0, null);
	}

	override function create(_:Event)
	{
		Save.instance = new Save();
		Language.instance = new Language();

		super.create(_);

		if (!_lostFocus) proceed();
	}

	override function onFocus(_:Event)
	{
		super.onFocus(_);

		if (!playing) proceed();
	}

	function proceed()
	{
		playing = true;

		if (Save.instance.seenIntro) FlxG.switchState(() -> new Chapter1());
		else FlxG.switchState(() -> new IntroState());
	}
}
