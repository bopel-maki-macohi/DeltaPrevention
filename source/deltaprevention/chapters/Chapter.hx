package deltaprevention.chapters;

import flixel.sound.FlxSound;
import flixel.addons.text.FlxTypeText;
import flixel.text.FlxText;
import flixel.FlxState;

class Chapter extends FlxState
{
	var piece = 0;

	var dialogueText:FlxTypeText;

	var lines:Array<String> = [];

	override function create()
	{
		super.create();

		add(dialogueText = new FlxTypeText(0, 0, 0, '', 16));
		dialogueText.screenCenter();
		dialogueText.completeCallback = onDialogueDone;

		if (lines.length == 0) speak(0, '');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		dialogueText.screenCenter(X);
	}

	function speak(line:Int, speaker:String)
	{
		dialogueText.resetText(lines[line] ?? 'Lorem Ipsum Dolor Sit Amet');
		dialogueText.sounds = [
			new FlxSound().load(Language.instance.getLangFile('dialogue/spkr_$speaker.ogg')),
		];
		dialogueText.start(dialogueText.delay, true, false, [SPACE]);
	}

	function onDialogueDone()
	{
		piece++;

		if (piece >= lines.length - 1) onChapterDialogueDone();
	}

	function onChapterDialogueDone() {}
}
