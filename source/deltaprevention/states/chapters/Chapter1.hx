package deltaprevention.states.chapters;

import flixel.FlxG;
import flixel.FlxCamera;

using StringTools;

class Chapter1 extends Chapter
{
	var lake:RealmMapSprite;

	var mapCam:FlxCamera;
	var uiCam:FlxCamera;

	override function create()
	{
		lines = Language.instance.getTextLangFile('dialogue/txt_chapter1.txt');

		FlxG.cameras.reset(mapCam = new FlxCamera());
		FlxG.cameras.add(uiCam = new FlxCamera(), false);
		uiCam.bgColor = 0x00000000;

		add(lake = new RealmMapSprite('standard', 'lake'));
		lake.visible = false;

		super.create();

		dialogueText.cameras = [uiCam];

		speak(0, 'gele');
	}

	override function onDialogueNext()
	{
		super.onDialogueNext();

		switch (piece)
		{
			case 1:
				mapCam.zoom = 2;
				lake.visible = true;
				dialogueText.y = dialogueText.height;
		}
	}

	override function onChapterDone()
	{
		super.onChapterDone();

		// TODO: dont forget to re-reset the camera
	}
}
