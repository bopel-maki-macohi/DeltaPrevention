package deltaprevention.chapters;

using StringTools;

class Chapter1 extends Chapter
{
	var map:RealmMap;
	var resetSeed:Bool = false;

	static var seed:NInt;

	override function create()
	{
		resetSeed = seed != null;
		if (seed == null) seed = Save.instance.mapRandom.currentSeed;
		else Save.instance.mapRandom.currentSeed = seed;

		lines = Language.instance.getTextLangFile('dialogue/txt_chapter1.txt');

		map = new RealmMap('standard', 'test');
		add(map.layers);
		map.loadLayers();

		super.create();

		speak(0, 'gele');
		map.layers.visible = false;
	}

	override function onDialogueNext()
	{
		super.onDialogueNext();

		switch (piece)
		{
			case 1: map.layers.visible = true;
		}
	}

	override function onChapterDone()
	{
		super.onChapterDone();

		if (resetSeed) Save.instance.mapRandom.resetInitialSeed();
	}
}
