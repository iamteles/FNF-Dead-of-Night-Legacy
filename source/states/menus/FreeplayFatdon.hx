package states.menus;

import base.MusicBeat.MusicBeatState;
import base.SongLoader.LegacySong;
import base.SongLoader.Song;
import dependency.Discord;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import funkin.*;
import lime.app.Application;
import states.substates.PauseSubstate;
import sys.FileSystem;

using StringTools;

/**
	This is the main menu state! Not a lot is going to change about it so it'll remain similar to the original, but I do want to condense some code and such.
	Get as expressive as you can with this, create your own menu!
**/
class FreeplayFatdon extends MusicBeatState
{
	public var curSelected:Int = -1;
	public var menuItems:FlxTypedGroup<FlxSprite>;
	public var camGame:FlxCamera;
	var unlocked:Int = 7;
	var canSelect:Bool = true;

	override function create()
	{
		super.create();

		ForeverTools.resetMenuMusic();

		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...Main.gameWeeks.length)
		{
			var imgPath:String = 'menus/fitdon/freeplay/none';
			if (!FlxG.save.data.paralyzed || Main.gameWeeks[i][0] != 'Paralyze')
				imgPath = 'menus/fitdon/freeplay/' + Main.gameWeeks[i][0];
			var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image(imgPath));
			bg.updateHitbox();
			bg.screenCenter();
            bg.alpha = 0;
			bg.ID = i;
			menuItems.add(bg);
        }

		changeSong(1);
    }

	override function update(elapsed:Float)
	{
		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
			Main.switchState(this, new MainMenu());
		}
		if(canSelect)
		{
			if (controls.UI_RIGHT_P)
				changeSong(1);
			if (controls.UI_LEFT_P)
				changeSong(-1);

			if (controls.ACCEPT)
			{
				FlxG.sound.play(Paths.sound("confirmMenu"), 1.5);
				// FlxG.camera.fade(FlxColor.WHITE,1);
				menuItems.forEach(function(spr:FlxSprite)
				{
					FlxFlicker.flicker(spr, .5, 0.06, false, false, function(flick:FlxFlicker)
					{
						playSong();
					});
				});
			}
		}


		super.update(elapsed);
    }

	function playSong() {
		var poop:String = Highscore.formatSong(Main.gameWeeks[curSelected][0].toLowerCase(),
			CoolUtil.difficulties.indexOf('NORMAL'));

		PlayState.SONG = Song.loadSong(poop, Main.gameWeeks[curSelected][0].toLowerCase());
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = 0;

		if (FlxG.sound.music != null)
			FlxG.sound.music.stop();

		Main.switchState(this, new PlayState());
	}

    function changeSong(side:Int) {

		curSelected += side;
		canSelect = false;

		if (curSelected >= unlocked)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = unlocked - 1;
		
		menuItems.forEach(function(spr:FlxSprite)
		{
		    if (spr.ID == curSelected)
		    {
				new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					canSelect = true;
					FlxTween.tween(spr, {alpha: 1}, 0.5, {ease: FlxEase.sineInOut});
				});
            }
            else
            {
					FlxTween.tween(spr, {alpha: 0}, 0.5, {ease: FlxEase.sineInOut});
            }
        });
    }
} 