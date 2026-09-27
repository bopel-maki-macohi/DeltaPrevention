package deltaprevention;

import flixel.group.FlxContainer.FlxTypedContainer;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;

class RealmMap extends FlxOgmo3Loader
{
	public static var standard_mappings:Array<Int> = [];
	public static var standard_random_indices:Array<Int> = [];
	public static var standard_random_choices:Array<Array<Int>> = [];

	public var realm(default, null):String;
	public var section(default, null):String;

	public var layers:FlxTypedContainer<FlxTilemap>;

	public function new(realm:String, section:String)
	{
		this.realm = realm;
		this.section = section;

		super(path('map.ogmo'), path('sections/$section.json'));

		layers = new FlxTypedContainer<FlxTilemap>();
	}

	public function loadLayer(layer:String, ?mapping:Array<Int>, ?randomIndices:Array<Int>, ?randomChoices:Array<Array<Int>>)
	{
		var tilemap:FlxTilemap = new FlxTilemap();
		tilemap.setCustomTileMappings(mapping, randomIndices, randomChoices, () -> return Save.instance.mapRandom.float());

		loadTilemap('chapters/realm_$realm/tileset.png', layer, tilemap);
		if (tilemap != null) layers.add(tilemap);
	}

	public function path(path:String) return 'chapters/realm_$realm/$path';
}
