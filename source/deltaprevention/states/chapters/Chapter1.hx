package deltaprevention.states.chapters;

import flixel.FlxG;
import flixel.FlxCamera;

using StringTools;

class Chapter1 extends Chapter
{
	var map:RealmMap;
	var mapCam:FlxCamera;
	var uiCam:FlxCamera;

	var resetSeed:Bool = false;

	static var seed:NInt;

	override function create()
	{
		resetSeed = seed != null;
		if (seed == null) seed = Save.instance.mapRandom.currentSeed;
		else Save.instance.mapRandom.currentSeed = seed;

		lines = Language.instance.getTextLangFile('dialogue/txt_chapter1.txt');

		FlxG.cameras.reset(mapCam = new FlxCamera());
		FlxG.cameras.add(uiCam = new FlxCamera(), false);
		uiCam.bgColor = 0x00000000;

		map = new RealmMap('standard', '0-0');
		add(map.layers);
		map.loadLayers(RealmMap.standard_mappings, RealmMap.standard_random_indices, RealmMap.standard_random_choices);

		super.create();

		dialogueText.cameras = [uiCam];

		speak(0, 'gele');
		map.layers.visible = false;
	}

	override function onDialogueNext()
	{
		super.onDialogueNext();

		switch (piece)
		{
			case 1:
				mapCam.zoom = 2;
				map.layers.visible = true;
				dialogueText.y = dialogueText.height;
		}
	}

	override function onChapterDone()
	{
		super.onChapterDone();

		if (resetSeed) Save.instance.mapRandom.resetInitialSeed();

		// TODO: dont forget to re-reset the camera
	}
}
