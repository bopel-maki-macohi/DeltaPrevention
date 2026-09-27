package deltaprevention.chapters;

import lime.utils.Assets;

using StringTools;

class Chapter1 extends Chapter
{
	override function create()
	{
		super.create();

		lines = [
			for (line in Assets.getText(Language.instance.getLangFile('dialogue/chapter1.txt')).split('\n')) line.trim()
		];

		speak(0, 'gele');
	}

	override function onDialogueDone()
	{
		super.onDialogueDone();

		trace(piece);

		switch (piece) {}
	}
}
