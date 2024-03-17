import Note;

var colors:Array<String> = ['purple', 'blue', 'green', 'red'];
var pixelSongs:Array<String> = ["senpai", "roses", "thorns"];

function postCreate()
{
	if (pixelSongs.contains(curSong.toLowerCase()))
	{
		for (i in game.unspawnNotes)
		{
			i.loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);

			i.animation.add('greenScroll', [6]);
			i.animation.add('redScroll', [7]);
			i.animation.add('blueScroll', [5]);
			i.animation.add('purpleScroll', [4]);

			i.animation.play(colors[i.noteData] + 'Scroll');

			if (i.isSustainNote)
			{
				i.loadGraphic(Paths.image('weeb/pixelUI/arrowEnds'), true, 7, 6);

				i.animation.add('purpleholdend', [4]);
				i.animation.add('greenholdend', [6]);
				i.animation.add('redholdend', [7]);
				i.animation.add('blueholdend', [5]);

				i.animation.add('purplehold', [0]);
				i.animation.add('greenhold', [2]);
				i.animation.add('redhold', [3]);
				i.animation.add('bluehold', [1]);

				i.animation.play(colors[i.noteData] + 'hold');
				i.x -= 30;
			}

			i.antialiasing = false;
			i.setGraphicSize(Std.int(i.width * game.daPixelZoom));
			i.updateHitbox();
		}
	}
}

function generateStaticArrows(i, p, a)
{
	if (pixelSongs.contains(curSong.toLowerCase()))
	{
		a.loadGraphic(Paths.image('weeb/pixelUI/arrows-pixels'), true, 17, 17);
		a.animation.add('green', [6]);
		a.animation.add('red', [7]);
		a.animation.add('blue', [5]);
		a.animation.add('purplel', [4]);

		a.setGraphicSize(Std.int(a.width * game.daPixelZoom));
		a.updateHitbox();
		a.antialiasing = false;

		switch (Math.abs(i))
		{
			case 0:
				a.animation.add('static', [0]);
				a.animation.add('pressed', [4, 8], 12, false);
				a.animation.add('confirm', [12, 16], 24, false);
			case 1:
				a.animation.add('static', [1]);
				a.animation.add('pressed', [5, 9], 12, false);
				a.animation.add('confirm', [13, 17], 24, false);
			case 2:
				a.animation.add('static', [2]);
				a.animation.add('pressed', [6, 10], 12, false);
				a.animation.add('confirm', [14, 18], 12, false);
			case 3:
				a.animation.add('static', [3]);
				a.animation.add('pressed', [7, 11], 12, false);
				a.animation.add('confirm', [15, 19], 24, false);
		}

		a.animation.play("static");
	}
}

function postUpdate(e)
{
	if (pixelSongs.contains(curSong.toLowerCase()))
	{
		for (spr in cpuStrums.members)
		{
			spr.centerOffsets();
		}

		for (note in notes)
		{
			if (note.isSustainNote)
				note.y -= 20;
		}
	}
}