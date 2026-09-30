package f_anim.states;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.sound.FlxSound;
import flixel.addons.text.FlxTypeText;
import flixel.FlxState;

class Scene extends FlxState
{
	var piece = 0;

	var autoProceed = true;
	var proceedable = false;
	var proceedTime:NFloat = null;

	var dialogueText:FlxTypeText;
	var dialogueTextBG:FlxSprite;
	var dialogueSound:FlxSound;

	var lines:Array<String> = [];

	override function create()
	{
		super.create();

		add(dialogueTextBG = new FlxSprite().makeGraphic(1, 1));
		dialogueTextBG.color = 0xFF000000;
		add(dialogueText = new FlxTypeText(0, 0, 0, '', 16));
		dialogueText.screenCenter();
		dialogueText.completeCallback = onDialogueDone;

		dialogueSound = new FlxSound();

		if (lines.length == 0) speak(0, null);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		dialogueText.screenCenter(X);

		dialogueTextBG.scale.set(dialogueText.width, dialogueText.height);
		dialogueTextBG.updateHitbox();

		dialogueTextBG.x = dialogueText.x;
		dialogueTextBG.y = dialogueText.y;

		if (proceedable)
		{
			if (autoProceed) onDialogueNext();
			if (!autoProceed && FlxG.keys.justPressed.ENTER) onDialogueNext();
		}
	}

	function speak(line:NInt, speaker:String, ?time:NFloat)
	{
		proceedable = false;
		proceedTime = time;

		dialogueText.resetText(lines[line ?? piece] ?? 'Lorem Ipsum Dolor Sit Amet');

		if (speaker == null) dialogueText.sounds = [];
		else dialogueText.sounds = [dialogueSound.load('sfx/dialogue/spkr_${speaker ?? 'default'}.ogg'),];

		dialogueText.start(dialogueText.delay, true, false, [SPACE]);
	}

	function onDialogueDone()
	{
		wait(proceedTime ?? 0.5, () ->
		{
			proceedable = true;
		});
	}

	function onDialogueNext()
	{
		proceedable = false;
		piece++;
	}

	function onChapterDone() {}

	function wait(time:Float, method:Void->Void) FlxTimer.wait(time, method);
}
