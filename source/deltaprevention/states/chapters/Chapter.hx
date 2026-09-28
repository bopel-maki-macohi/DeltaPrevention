package deltaprevention.states.chapters;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.sound.FlxSound;
import flixel.addons.text.FlxTypeText;
import flixel.FlxState;

class Chapter extends FlxState
{
	var piece = 0;
	var proceedable = false;

	var dialogueText:FlxTypeText;
	var dialogueTextBG:FlxSprite;

	var lines:Array<String> = [];

	override function create()
	{
		super.create();

		add(dialogueTextBG = new FlxSprite().makeGraphic(1,1));
		dialogueTextBG.color = 0xFF000000;
		add(dialogueText = new FlxTypeText(0, 0, 0, '', 16));
		dialogueText.screenCenter();
		dialogueText.completeCallback = onDialogueDone;

		if (lines.length == 0) speak(0, '');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		dialogueText.screenCenter(X);

		dialogueTextBG.scale.set(dialogueText.width,dialogueText.height);
		dialogueTextBG.updateHitbox();

		dialogueTextBG.x = dialogueText.x;
		dialogueTextBG.y = dialogueText.y;

		if (proceedable && FlxG.keys.justPressed.ENTER) onDialogueNext();
	}

	function speak(line:NInt, speaker:String)
	{
		proceedable = false;
		dialogueText.resetText(lines[line ?? piece] ?? 'Lorem Ipsum Dolor Sit Amet');
		dialogueText.sounds = [
			new FlxSound().load('sfx/dialogue/spkr_$speaker.ogg'),
		];
		dialogueText.start(dialogueText.delay, true, false, [SPACE]);
	}

	function onDialogueDone()
	{
		proceedable = true;
	}

	function onDialogueNext()
	{
		proceedable = false;
		piece++;

		if (piece >= lines.length - 1) onChapterDone();
	}

	function onChapterDone() {}

	function wait(time:Float, method:Void->Void) FlxTimer.wait(time, method);
}
