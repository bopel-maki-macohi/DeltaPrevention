package deltaprevention.states.chapters;

import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.FlxCamera;

using StringTools;

class Chapter1 extends Chapter
{
	var lake:RealmMapSprite;
	var lakeLexia:Character;
	var lakeGele:Character;

	var mapCam:FlxCamera;
	var uiCam:FlxCamera;

	override function create()
	{
		lines = Language.instance.getTextLangFile('dialogue/txt_chapter1.txt');

		makeCams();

		add(lake = new RealmMapSprite('standard', 'lake'));
		lake.alpha = 0.001;

		add(lakeLexia = new Character('c1-intro/lexia', 32, 48, [
			'sleep' => {frames: [0]},
			'hit' => {frames: [1, 2], fps: 16},
			'sideeye' => {frames: [3]},
		]));
		lakeLexia.play('sleep');

		add(lakeGele = new Character('c1-intro/gele', 48, 64, [
			'knee' => {frames: [0]},
			'jab' => {frames: [1, 2], fps: 30},
			'stand' => {frames: [3]},
		]));
		lakeGele.play('knee');
		lakeGele.alpha = 0.001;

		super.create();

		dialogueTextBG.alpha = 0.001;
		dialogueTextBG.cameras = dialogueText.cameras = [uiCam];
		dialogueText.y -= dialogueText.height * 4;

		lake.screenCenter();

		lakeLexia.screenCenter();

		lakeGele.screenCenter();
		lakeGele.x -= lakeGele.width / 2;

		speak(null, 'default');
	}

	override function onDialogueDone()
	{
		switch (piece)
		{
			case 1:

			default: super.onDialogueDone();
		}
	}

	override function onDialogueNext()
	{
		super.onDialogueNext();

		switch (piece)
		{
			case 1:
				dialogueTextBG.alpha = 1;
				lakeGele.alpha = lake.alpha = 1;

				mapCam.zoom = 0.75;

				FlxTween.tween(mapCam, {zoom: 2}, 2, {ease: FlxEase.backOut});

				wait(0.975, () -> lakeGele.play('jab'));
				wait(1, () -> lakeLexia.play('hit'));
				wait(1, () -> FlxG.sound.play('sfx/dmg.ogg'));
				wait(1.1, () -> lakeGele.play('knee'));
				wait(1.5, onDialogueNext);

			case 2: lakeLexia.play('sideeye');
		}

		speak(null, switch (piece)
		{
			case 1, 3, 6: 'gele';
			case 2, 4, 5: 'lexia';
			case _: null;
		});

		endingCheck();
	}

	override function onChapterDone()
	{
		super.onChapterDone();

		FlxG.switchState(() -> new MenuState());
	}

	function makeCams()
	{
		FlxG.cameras.reset(mapCam = new FlxCamera());
		FlxG.cameras.add(uiCam = new FlxCamera(), false);
		uiCam.bgColor = 0x00000000;
	}
}
