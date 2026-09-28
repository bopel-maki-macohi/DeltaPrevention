package deltaprevention;

import flixel.system.scaleModes.FillScaleMode;
import haxe.Json;
import lime.utils.Assets;
import flixel.FlxG;
import openfl.events.Event;
import flixel.FlxGame;

class Main extends FlxGame
{
	public static var deltaColor:Int = 0xFFFFA548;

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

		FlxG.mouse.enabled = false;

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

		FlxG.switchState(() -> new MenuState());
	}
}
