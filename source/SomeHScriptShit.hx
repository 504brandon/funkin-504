import flixel.FlxG;
import flixel.ui.FlxBar;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * IT IS NOT RECCOMENDED TO USE THIS FOR SOURSE CODE THIS IS INTENDED TO BE A HANDLER FOR HSCRIPT
 */
class FlxBarHandler extends FlxTypedGroup<Dynamic>
{
	var bar:FlxBar;

	override function new(x:Float, y:Float, direction:String, width:Int, height:Int, parent:Dynamic, track:String, min:Float, max:Float, empty = 0xFFffffff, fill = 0xff000000)
	{
		super();

		bar = new FlxBar(x, y, stringToDirection(direction), width, height, parent, track, min, max);
		bar.createFilledBar(empty, fill);
		add(bar);
	}

	function stringToDirection(str:String)
	{
		switch (str)
		{
			default:
				return LEFT_TO_RIGHT;
		}
	}
}