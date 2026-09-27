package deltaprevention;

import flixel.FlxG;
import lime.utils.Assets;
import flixel.addons.display.FlxRuntimeShader;

class HeatwaveShader extends FlxRuntimeShader
{
	public function new()
	{
		super(Assets.getText('shaders/heatwave.frag'));

        offset = 0;
        x = 0;
        y = 0;
        width = FlxG.width;
        height = FlxG.height;
	}

	public var x(get, set):Float;

	function get_x():Float return getFloat('x');

	function set_x(x:Float):Float
	{
		setFloat('x', x);
		return getFloat('x');
	}

	public var y(get, set):Float;

	function get_y():Float return getFloat('y');

	function set_y(y:Float):Float
	{
		setFloat('y', y);
		return getFloat('y');
	}

	public var width(get, set):Float;

	function get_width():Float return getFloat('width');

	function set_width(width:Float):Float
	{
		setFloat('width', width);
		return getFloat('width');
	}

	public var height(get, set):Float;

	function get_height():Float return getFloat('height');

	function set_height(height:Float):Float
	{
		setFloat('height', height);
		return getFloat('height');
	}

	public var offset(get, set):Float;

	function get_offset():Float return getFloat('offset');

	function set_offset(offset:Float):Float
	{
		setFloat('offset', offset);
		return getFloat('offset');
	}
}
