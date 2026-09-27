package deltaprevention.chapters;

import lime.utils.Assets;

using StringTools;

class Chapter1 extends Chapter
{
	override function create()
	{
		super.create();

		lines = Language.instance.getTextLangFile('dialogue/txt_chapter1.txt');

		speak(0, 'gele');
	}

	override function onDialogueDone()
	{
		super.onDialogueDone();

		trace(piece);

		switch (piece) {}
	}
}
