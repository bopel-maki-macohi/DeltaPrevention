package deltaprevention;

import flixel.util.FlxSave;

class Save extends FlxSave
{
	public static var instance:Save;

	override public function new()
	{
		super();

		bind('DeltaPrevention', '.Maverick');

		gameData ??= {};
		#if FORCE_INTRO
		seenIntro = false;
		#else
		seenIntro ??= false;
		#end
		language ??= 'eng-US';
	}

	public var gameData(get, set):Dynamic;

	function get_gameData():Dynamic return data.gameData;

	function set_gameData(gameData:Dynamic):Dynamic return data.gameData = gameData;

	public var seenIntro(get, set):Null<Bool>;

	function get_seenIntro():Null<Bool> return gameData.seenIntro;

	function set_seenIntro(seenIntro:Null<Bool>):Null<Bool> return gameData.seenIntro = seenIntro;

	public var language(get, set):String;

	function get_language():String return gameData.language;

	function set_language(language:String):String return gameData.language = language;
}
