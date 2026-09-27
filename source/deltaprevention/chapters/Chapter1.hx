package deltaprevention.chapters;

import flixel.text.FlxText;
import flixel.FlxState;

class Chapter1 extends FlxState
{
	var dialogueText:FlxText;

	override function create()
	{
		super.create();

		add(dialogueText = new FlxText(0, 0, 0, 'LEXIA!!', 16));
		dialogueText.screenCenter();
	}
}
