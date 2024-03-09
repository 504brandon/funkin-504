var blackness;

function create() {}

function postCreate()
{
	blackness = new FlxSprite().makeGraphic(FlxG.width * 10, FlxG.height * 10, 0xff181818);
	blackness.blend = "lighten";
	blackness.screenCenter();
	blackness.scrollFactor.set();
	add(blackness);
}

function boyfriendNoteHit(n)
{
	if (blackness.alpha != 0)
	{
		var anims = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];

		var sprite = new Boyfriend(boyfriend.x, boyfriend.y, boyfriend.curCharacter);
		sprite.alpha = 0.97;
		sprite.color = 0xff00eaff;
		sprite.playAnim(anims[n.noteData]);
		insert(4, sprite);

		FlxTween.tween(sprite, {alpha: 0, x: sprite.x - 60, y: sprite.y - 10}, 0.4, {
			onComplete: function(tween)
			{
				sprite.destroy();
			}
		});
	}
}

function dadNoteHit(n)
{
	if (blackness.alpha != 0)
	{
		var anims = ['singLEFT', 'singDOWN', 'singUP', 'singRIGHT'];

		var sprite = new Character(dad.x, dad.y, dad.curCharacter);
		sprite.alpha = 0.97;
		sprite.color = 0xffdc0000;
		sprite.playAnim(anims[n.noteData]);
		insert(4, sprite);

		FlxTween.tween(sprite, {alpha: 0, x: sprite.x + 60, y: sprite.y + 10}, 0.4, {
			onComplete: function(tween)
			{
				sprite.destroy();
			}
		});
	}
}

function stepHit()
{
	switch (curStep)
	{
		case 10:
			FlxTween.tween(blackness, {alpha: 0.85});
		case 65:
			FlxG.camera.flash(0xFFffffff, 0.2);

			FlxG.camera.zoom += 0.21;
			camHUD.zoom += 0.20;
			FlxTween.tween(blackness, {alpha: 0}, 0.4);
        case 575:
            FlxG.camera.flash(0xFFffffff, 0.2);

			FlxG.camera.zoom += 0.21;
			camHUD.zoom += 0.20;
			FlxTween.tween(blackness, {alpha: 0.85}, 0.4);
        case 336:
			FlxG.camera.zoom += 0.21;
			camHUD.zoom += 0.20;
            blackness.alpha = 0;
	}
}
