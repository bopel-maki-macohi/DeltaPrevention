package deltaprevention;

import flixel.math.FlxRandom;
import flixel.util.FlxSave;

class Save extends FlxSave
{
	public static var instance:Save;

	public var mapRandom:FlxRandom;

	override public function new()
	{
		super();

		bind('DeltaPrevention', '.Maverick');

		gameData ??= {};

		#if NEW_SEED
		mappingSeed = null;
		#end
		mapRandom = new FlxRandom(mappingSeed);

		#if FORCE_INTRO
		seenIntro = false;
		#else
		seenIntro ??= false;
		#end

		language ??= 'eng-US';
		mappingSeed ??= mapRandom.currentSeed;
	}

	public var gameData(get, set):Dynamic;

	function get_gameData():Dynamic return data.gameData;

	function set_gameData(gameData:Dynamic):Dynamic return data.gameData = gameData;

	public var seenIntro(get, set):NBool;

	function get_seenIntro():NBool return gameData.seenIntro;

	function set_seenIntro(seenIntro:NBool):NBool return gameData.seenIntro = seenIntro;

	public var language(get, set):String;

	function get_language():String return gameData.language;

	function set_language(language:String):String return gameData.language = language;

	public var mappingSeed(get, set):NInt;

	function get_mappingSeed():NInt return gameData.mappingSeed;

	function set_mappingSeed(mappingSeed:NInt):NInt return gameData.mappingSeed = mappingSeed;
}
