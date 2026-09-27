package deltaprevention.chapters;

import lime.utils.Assets;

using StringTools;

class Chapter1 extends Chapter
{
	override function create()
	{
		lines = Language.instance.getTextLangFile('dialogue/txt_chapter1.txt');

		super.create();

		speak(0, 'gele');
	}

	override function onDialogueDone()
	{
		super.onDialogueDone();

		switch (piece) {}
	}
}
