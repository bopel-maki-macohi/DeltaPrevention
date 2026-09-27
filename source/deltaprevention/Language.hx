package deltaprevention;

import lime.utils.Assets;
import flixel.util.FlxSignal;

using StringTools;

class Language
{
	public static var instance:Language;

	public function new()
	{
		onLanguageSwitch = new FlxSignal();

		switchLanguage(Save.instance.language);
	}

	public var lang(default, null):String = 'eng-US';

	public var onLanguageSwitch:FlxSignal;

	public function switchLanguage(newLang:String)
	{
		this.lang = newLang;
		onLanguageSwitch.dispatch();
	}

	public function getLangFile(file:String):String return 'lang/$lang/$file';

	public function getTextLangFile(file:String):Array<String> return [
		for (line in Assets.getText(getLangFile(file))?.split('\n') ?? []) line.trim()
	];
}
