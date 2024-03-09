package fps;

import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import lime.app.Application;
import fps.memory.Memory;
import fps.fabric.engine.Utilities;
import openfl.text.TextField;
import openfl.text.TextFormat;
#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
#if flash
import openfl.Lib;
#end

using StringTools;

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class Text extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new(x:Float = 10, y:Float = 10)
	{
		super();

		this.x = x;
		this.y = y;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("VCR OSD Mono", 12);

		cacheCount = 0;
		currentTime = 0;
		times = [];
		autoSize = LEFT;

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end
	}

	// Event Handlers
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		if (currentCount != cacheCount)
		{
			text = "FPS: "
				+ currentFPS
				+ "\nMEM: "
				+ Utilities.format_bytes(Memory.getCurrentUsage())
				+ "\nMEM Peak: "
				+ Utilities.format_bytes(Memory.getPeakUsage())
				+ "\nState: source/"
				+ Type.getClassName(Type.getClass(flixel.FlxG.state)).replace(".", "/")
				+ ".hx";
		}

		if (currentFPS < 20)
			this.textColor = 0xffff0000;
		else if (currentFPS < 40)
			this.textColor = 0xffffe600;
		else if (currentFPS < 70)
			this.textColor = 0xffbbff00;
		else
			this.textColor = 0xfffcfcfc;

		cacheCount = currentCount;
	}
}
