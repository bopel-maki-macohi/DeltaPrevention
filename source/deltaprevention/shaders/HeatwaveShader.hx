package deltaprevention.shaders;

import flixel.FlxG;
import lime.utils.Assets;
import flixel.addons.display.FlxRuntimeShader;

class HeatwaveShader extends FlxRuntimeShader
{
	public function new()
	{
		super(Assets.getText('shaders/heatwave.frag'));

        time = 0;
        scale = .5;
        amp = 0.01;
	}

	public var time(get, set):Float;

	function get_time():Float return getFloat('time');

	function set_time(time:Float):Float
	{
		setFloat('time', time);
		return getFloat('time');
	}

	public var scale(get, set):Float;

	function get_scale():Float return getFloat('scale');

	function set_scale(scale:Float):Float
	{
		setFloat('scale', scale);
		return getFloat('scale');
	}

	public var amp(get, set):Float;

	function get_amp():Float return getFloat('amp');

	function set_amp(amp:Float):Float
	{
		setFloat('amp', amp);
		return getFloat('amp');
	}
}
