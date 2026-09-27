package deltaprevention;

import haxe.Json;
import lime.utils.Assets;
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
		function getRandomTiles(length = 4, offset = 0, ?chance:NFloat)
		{
			var choices = [];
			for (i in 0...length) if (Save.instance.mapRandom.bool(chance ?? (1 / length) * 100)) choices.push(offset + i);

			return choices;
		}

		function indicesAndChoices(indicesList:Array<Int>, choicesList:Array<Array<Int>>, indice = 0, length = 4, ?chance:NFloat)
		{
			if (indicesList == null || choicesList == null) return;
			var choices = getRandomTiles(length, indice, chance);

			if (choices.length != 0)
			{
				indicesList.push(indice);
				choicesList.push(choices);
			}
		}

		var s_m:Array<Int> = [];
		var s_ri:Array<Int> = [65, 89];
		var s_rc:Array<Array<Int>> = [[65, 66, 67, 68], [89, 90]];

		for (i in 0...16) indicesAndChoices(s_ri, s_rc, 1 + (i * 4), 4, switch (i + 1)
		{
			case 1:
				50;

			case _:
				null;
		});

		// trace(s_ri);
		// trace(s_rc);

		RealmMap.standard_mappings = s_m;
		RealmMap.standard_random_indices = s_ri;
		RealmMap.standard_random_choices = s_rc;
	}
}
