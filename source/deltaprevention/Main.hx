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

		var standard_tilesetData = Json.parse(Assets.getText('chapters/realm_standard/tileset.json'));
		var tags:Array<Dynamic> = standard_tilesetData?.meta?.frameTags ?? [];

		var sm:Array<Int> = [];
		var sri:Array<Int> = [];
		var src:Array<Array<Int>> = [];

		var debugLen = 0;

		for (i => tag in tags)
		{
			var name:String = tag.name;

			var from:Int = tag.from;
			var to:Int = tag.to;
			
			if (name == 'debug')
			{
				debugLen = to;
				continue;
			}

			var diff = (to - from) + 1;

			sm.push(i - 1);
			sri.push(from);

			var choices = [for (i in 0...diff) from + i];

			switch (name)
			{
				case 'water': src.push(choices);
				default:
					var replacechoices = [
						for (choice in choices) if (Save.instance.mapRandom.bool((1 / diff) * 100)) choice
					];
					src.push((replacechoices.length == 0) ? [from] : replacechoices);
			}
		}

		RealmMap.standard_mappings = sm;
		RealmMap.standard_random_indices = sri;
		RealmMap.standard_random_choices = src;

		trace(RealmMap.standard_mappings);
		trace(RealmMap.standard_random_indices);
		trace(RealmMap.standard_random_choices);

		super.create(_);

		if (Save.instance.seenIntro) FlxG.switchState(() -> new Chapter1());
		else FlxG.switchState(() -> new IntroState());
	}
}
