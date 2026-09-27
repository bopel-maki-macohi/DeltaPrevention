package deltaprevention.objects;

import flixel.FlxSprite;

class RealmMapSprite extends FlxSprite
{
	public var realm(default, null):String;
	public var section(default, null):String;

	public function new(realm:String, section:String)
	{
		this.realm = realm;
		this.section = section;

		super(0, 0, spritePath('sections/$section.png'));
	}

	public function spritePath(path:String) return 'chapters/realm_$realm/$path';
}
