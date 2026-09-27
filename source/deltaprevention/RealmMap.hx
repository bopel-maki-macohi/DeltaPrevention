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

	public function loadLayer(tileLayer:String, ?mapping:Array<Int>, ?randomIndices:Array<Int>, ?randomChoices:Array<Array<Int>>)
	{
		var tileGraphic = 'chapters/realm_$realm/tileset.png';

		var tilemap = new FlxTilemap();
		tilemap.setCustomTileMappings(mapping, randomIndices, randomChoices, () -> return Save.instance.mapRandom.float());

		var layer = FlxOgmo3Loader.getTileLayer(level, tileLayer);
		var tileset = FlxOgmo3Loader.getTilesetData(project, layer.tileset);
		switch (layer.arrayMode)
		{
			case 0:
				tilemap.loadMapFromArray([for (z in layer.data) z + 1], layer.gridCellsX, layer.gridCellsY, tileGraphic, tileset.tileWidth, tileset.tileHeight);
			case 1:
				var newData2D:Array<Array<Int>> = [];
				for (y in layer.data2D) newData2D.push([for (x in y) x + 1]);

				tilemap.loadMapFrom2DArray(newData2D, tileGraphic, tileset.tileWidth, tileset.tileHeight);
		}

		if (tilemap != null) layers.add(tilemap);
	}

	public function path(path:String) return 'chapters/realm_$realm/$path';

	public function loadLayers(?mapping:Array<Int>, ?randomIndices:Array<Int>, ?randomChoices:Array<Array<Int>>)
	{
		for (layer in this.level.layers) loadLayer(layer.name, mapping, randomIndices, randomChoices);
	}
}
