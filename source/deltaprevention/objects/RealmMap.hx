package deltaprevention.objects;

import flixel.util.FlxSort;
import flixel.group.FlxContainer.FlxTypedContainer;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;

class RealmMap extends FlxOgmo3Loader
{
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
		if (randomIndices != null
			&& (randomChoices != null || randomChoices.length > 0)) tilemap.setCustomTileMappings(mapping, randomIndices, randomChoices,);

		var layer = FlxOgmo3Loader.getTileLayer(level, tileLayer);
		var tileset = FlxOgmo3Loader.getTilesetData(project, layer.tileset);

		switch (layer.arrayMode)
		{
			case 0: tilemap.loadMapFromArray(layer.data, layer.gridCellsX, layer.gridCellsY, tileGraphic, tileset.tileWidth, tileset.tileHeight);
			case 1: tilemap.loadMapFrom2DArray(layer.data2D, tileGraphic, tileset.tileWidth, tileset.tileHeight);
		}

		layers.add(tilemap);
		layers.sort((i, a, b) -> return FlxSort.byValues(FlxSort.DESCENDING, a.ID, b.ID));
	}

	public function path(path:String) return 'chapters/realm_$realm/$path';

	public function loadLayers(?mapping:Array<Int>, ?randomIndices:Array<Int>, ?randomChoices:Array<Array<Int>>)
	{
		for (layer in this.level.layers) loadLayer(layer.name, mapping, randomIndices, randomChoices);

		return this.layers;
	}

	// public function loadStandardLayers() return loadLayers(standard_mappings, standard_random_indices, standard_random_choices);
}
