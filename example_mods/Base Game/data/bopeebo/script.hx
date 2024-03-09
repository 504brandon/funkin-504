function beatHit()
{
	if (curBeat % 8 == 7 && curSong == 'Bopeebo')
	{
		boyfriend.playAnim('hey', true);
        gf.playAnim("cheer", true);
        FlxG.camera.zoom += 0.4;
	}
}