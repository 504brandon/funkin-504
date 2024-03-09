import openfl.Assets;

typedef JsonPrefs = {
    var preferences:Array<Dynamic>;
};

typedef JsonChars = {
	var spritesheet:String;
	var anims:Array<Dynamic>;
}

class ModHandler
{
	public static function loadMods()
	{
		polymod.Polymod.init({
			modRoot: "mods",
			dirs: [Assets.getText(Paths.txt("modSelected"))],
			errorCallback: (e) ->
			{
				trace(e.message);
			},
			frameworkParams: {
				assetLibraryPaths: [
					"songs" => "assets/songs",
					"images" => "assets/images",
					"shared" => 'assets/shared',
					"data" => "assets/data",
					"notes" => "assets/notes",
					"characters" => "assets/characters",
					"fonts" => "assets/fonts",
					"sounds" => "assets/sounds",
					"music" => "assets/music",
					"tutorial" => "assets/tutorial",
					"week1" => "assets/week1",
					"week2" => "assets/week2",
					"week3" => "assets/week3",
					"week4" => "assets/week4",
					"week5" => 'assets/week5',
					"week6" => 'assets/week6',
					"week7" => 'assets/week7'
				]
			}
		});
	}

	public static function loadHScript()
	{
		HScript.parser = new hscript.Parser();
		HScript.parser.allowJSON = true;
		HScript.parser.allowMetadata = true;
		HScript.parser.allowTypes = true;
		HScript.parser.preprocesorValues = [
			"desktop" => #if (desktop) true #else false #end,
			"windows" => #if (windows) true #else false #end,
			"mac" => #if (mac) true #else false #end,
			"linux" => #if (linux) true #else false #end,
			"debugBuild" => #if (debug) true #else false #end
		];
	}
}
