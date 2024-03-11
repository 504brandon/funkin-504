package editors;

import openfl.net.FileReference;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUIInputText;

using StringTools;

class FreeplayEditor extends MusicBeatState
{
	// editor shit
	var songName:FlxUIInputText;
	var charName:FlxUIInputText;
	var saveButton:FlxButton;

	// display shit
	var songArray:Array<Alphabet> = [];
	var iconArray:Array<HealthIcon> = [];

	// state shit
	var songAmmont:Int = 1;
	var curSelected:Int = 0;

	override public function new(songAmmount:Int = 3)
	{
		super();

		this.songAmmont = songAmmount;
	}

	override public function create()
	{
		FlxG.mouse.enabled = true;
		FlxG.mouse.visible = true;

		songName = new FlxUIInputText(FlxG.width * 0.76, 0, 300, "Bopeebo", 24, FlxColor.BLACK, FlxColor.GRAY);
		add(songName);

		charName = new FlxUIInputText(songName.x, songName.y + 40, 300, "dad", 24, FlxColor.BLACK, FlxColor.GRAY);
		add(charName);

		saveButton = new FlxButton(charName.x + 221, charName.y + 35, "Save Freeplay", function()
		{
			var file = new FileReference();

            var songShit:String = "";

            for (i in 0...songArray.length) {
                if (songShit.length > 0)
                    songShit += "\n";

                songShit += songArray[i].text + ":" + iconArray[i].char;
            }

			file.save(songShit, "freeplaySonglist.txt");
		});
		add(saveButton);

		for (i in 0...songAmmont)
		{
			var songText = new Alphabet(0, (70 * i) + 30, "Bopeebo", true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			songArray.push(songText);
			add(songText);

			var songIcon = new HealthIcon("dad");
			songIcon.ID = i;
			songIcon.sprTracker = songText;
			iconArray.push(songIcon);
			add(songIcon);
		}

		changeSelection();

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (songName.hasFocus && FlxG.keys.justPressed.ENTER)
		{
			songArray[curSelected].kill();
            songArray.remove(songArray[curSelected]);

			var songText = new Alphabet(0, 120, songName.text, true);
            songText.isMenuItem = true;
			songText.targetY = curSelected;
            songArray.insert(curSelected, songText);
			iconArray[curSelected].sprTracker = songText;
			add(songText);

			changeSelection();
		}

		if (charName.hasFocus && FlxG.keys.justPressed.ENTER)
			iconArray[curSelected].changeIcon(charName.text.toLowerCase());

		if (controls.UI_UP_P && !charName.hasFocus)
			changeSelection(-1);
		if (controls.UI_DOWN_P && !charName.hasFocus)
			changeSelection(1);

		super.update(elapsed);
	}

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songArray.length - 1;
		if (curSelected >= songArray.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

		for (item in songArray)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}