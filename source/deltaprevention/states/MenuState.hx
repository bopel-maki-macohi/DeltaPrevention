package deltaprevention.states;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.FlxState;

class MenuState extends FlxState
{
	var deltaCrystal:FlxSprite;

	var title:FlxText;
	var pressToPlay:FlxText;

	override function create()
	{
		super.create();

		FlxG.cameras.reset();

		if (Save.instance.seenIntro)
		{
			add(deltaCrystal = new FlxSprite().loadGraphic('deltacrystal.png'));
			deltaCrystal.screenCenter();
		}

		add(title = new FlxText(0, 0, 0, 'Delta Prevention', 16));
		add(pressToPlay = new FlxText(0, 0, 0, 'Press ENTER to play', 16));

		title.screenCenter(X);
		title.y = title.height;

		pressToPlay.screenCenter(X);
		pressToPlay.y = FlxG.height - (pressToPlay.height * 2);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ENTER) proceed();
	}

	function proceed()
	{
		if (!Save.instance.seenIntro) FlxG.switchState(() -> new IntroState());
		else FlxG.switchState(() -> new Chapter1());
	}
}
