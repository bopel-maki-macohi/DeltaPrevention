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

		FlxG.cameras.reset(mapCam = new FlxCamera());
		FlxG.cameras.add(uiCam = new FlxCamera(), false);
		uiCam.bgColor = 0x00000000;

		add(lake = new RealmMapSprite('standard', 'lake'));
		lake.alpha = 0.001;
		lake.screenCenter();

		add(lakeLexia = new Character('c1-intro/lexia', 32, 48, [
			'sleep' => {frames: [0]},
			'hit' => {frames: [1, 2], fps: 16},
			'sideeye' => {frames: [3]},
		]));
		lakeLexia.screenCenter();
		lakeLexia.play('sleep');

		add(lakeGele = new Character('c1-intro/gele', 48, 64, [
			'knee' => {frames: [0]},
			'jab' => {frames: [1, 2], fps: 30},
			'stand' => {frames: [3]},
		]));
		lakeGele.screenCenter();
		lakeGele.play('knee');
		lakeGele.alpha = 0.001;
		lakeGele.x -= lakeGele.width / 2;

		super.create();

		dialogueTextBG.cameras = dialogueText.cameras = [uiCam];
		dialogueTextBG.alpha = 0.001;

		dialogueText.y -= dialogueText.height * 2;

		speak(null, 'gele');
	}

	override function onDialogueDone()
	{
		super.onDialogueDone();

		switch (piece)
		{
			case 1: proceedable = false;
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
				dialogueText.y = dialogueText.height;

				FlxTween.tween(mapCam, {zoom: 2}, 2, {ease: FlxEase.backOut});

				FlxTimer.wait(0.975, () -> lakeGele.play('jab'));
				FlxTimer.wait(1, () -> lakeLexia.play('hit'));
				FlxTimer.wait(1.1, () -> lakeGele.play('knee'));
				FlxTimer.wait(1.5, onDialogueNext);

				speak(null, 'gele');

			case 2:
				lakeLexia.play('sideeye');
				speak(null, 'lexia');
		}
	}

	override function onChapterDone()
	{
		super.onChapterDone();

		// TODO: dont forget to re-reset the camera
	}
}
