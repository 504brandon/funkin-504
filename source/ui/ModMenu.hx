package ui;

import ui.TextMenuList.TextMenuItem;
import openfl.Assets;
#if sys
import sys.io.File;
import sys.FileSystem;
#end
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.FlxG;
import ui.AtlasText.AtlasFont;

class ModMenu extends ui.OptionsState.Page
{
	var items:TextMenuList;
	var menuCamera:FlxCamera;
	var camFollow:FlxObject;

	public function new()
	{
		super();

		menuCamera = new SwagCamera();
		FlxG.cameras.add(menuCamera, false);
		menuCamera.bgColor = 0x0;
		camera = menuCamera;

		add(items = new TextMenuList());

		for (folder in FileSystem.readDirectory("./mods"))
		{
			items.createItem(42, (120 * items.length) + 30, folder, AtlasFont.Bold, function()
			{
				File.saveBytes('./' + Paths.txt('modSelected'), haxe.io.Bytes.ofString(folder));

                FlxG.switchState(new TitleState());
			});
		}

		camFollow = new FlxObject(FlxG.width / 2, 0, 140, 70);
		if (items != null)
			camFollow.y = items.selectedItem.y;

		menuCamera.follow(camFollow, null, 0.06);
		var margin = 160;
		menuCamera.deadzone.set(0, margin, menuCamera.width, 40);
		menuCamera.minScrollY = 0;

		items.onChange.add(function(selected)
		{
			camFollow.y = selected.y;
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}