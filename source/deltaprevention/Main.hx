package deltaprevention;

import haxe.Json;
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

		addRealmMappings();

		super.create(_);

		if (Save.instance.seenIntro) FlxG.switchState(() -> new Chapter1());
		else FlxG.switchState(() -> new IntroState());
	}

	function addRealmMappings()
	{
		function getRandomTiles(length = 4, offset = 0) return [
			for (i in 0...length) if (Save.instance.mapRandom.bool((1 / length) * 100)) offset + i
		];

		function indicesAndChoices(indicesList:Array<Int>, choicesList:Array<Array<Int>>, indice = 0, length = 4)
		{
			if (indicesList == null || choicesList == null) return;
			var choices = getRandomTiles(length, indice);

			if (choices.length != 0)
			{
				indicesList.push(indice);
				choicesList.push(choices);
			}
		}

		var s_m:Array<Int> = [];
		var s_ri:Array<Int> = [64];
		var s_rc:Array<Array<Int>> = [[64, 65, 66, 67]];

		for (i in 0...16) indicesAndChoices(s_ri, s_rc, i * 4, 4);

		RealmMap.standard_mappings = s_m;
		RealmMap.standard_random_indices = s_ri;
		RealmMap.standard_random_choices = s_rc;
	}
}
