package ui;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class ColorsMenu extends ui.OptionsState.Page
{
	var curSelected:Int = 0;

	var grpNotes:FlxTypedGroup<Note>;

	var noteColorText:FlxTypedGroup<FlxText>;

	public function new()
	{
		super();

		noteColorText = new FlxTypedGroup<FlxText>();
		add(noteColorText);

		grpNotes = new FlxTypedGroup<Note>();
		add(grpNotes);

		for (i in 0...4)
		{
			var note:Note = new Note(0, i);
			note.x = (100 * i) + i;
			note.screenCenter(Y);
			grpNotes.add(note);

			var text = new FlxText(note.y - 40, note.x, FlxG.width, "0", 9);
			text.setFormat(Paths.font("vcr.ttf"), 9, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			noteColorText.add(text);
		}
	}

	var colorArray:Array<Float> = [];

	override function update(elapsed:Float)
	{
		for (i in 0...4) {
			if (i == curSelected){
				grpNotes.members[i].alpha = 1;
				noteColorText.members[i].alpha = 1;
			}else{
				grpNotes.members[i].alpha = 0.50;
				noteColorText.members[i].alpha = 0.50;
			}

			noteColorText.members[i].text = "" + grpNotes.members[i].colorSwap.hueShit;

			colorArray.push(grpNotes.members[i].colorSwap.hueShit);
		}

		PreferencesMenu.setPref("noteColors", colorArray);

		colorArray = [];

		if (controls.UI_RIGHT_P)
			curSelected += 1;
		if (controls.UI_LEFT_P)
			curSelected -= 1;

		if (curSelected < 0)
			curSelected = grpNotes.members.length - 1;
		if (curSelected >= grpNotes.members.length)
			curSelected = 0;

		if (controls.UI_UP)
		{
			grpNotes.members[curSelected].colorSwap.update(elapsed * 0.3);
			Note.arrowColors[curSelected] += elapsed * 0.3;
		}

		if (controls.UI_DOWN)
		{
			grpNotes.members[curSelected].colorSwap.update(-elapsed * 0.3);
			Note.arrowColors[curSelected] += -elapsed * 0.3;
		}

		super.update(elapsed);
	}
}
