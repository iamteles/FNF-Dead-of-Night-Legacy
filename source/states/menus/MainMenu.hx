package states.menus;

import base.*;
import base.MusicBeat.MusicBeatState;
import base.SongLoader.Song;
import base.WeekParser.WeekDataDef;
import base.WeekParser.WeekSongDef;
import dependency.*;
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
import lime.app.Application;
import states.substates.PauseSubstate;
import sys.FileSystem;

using StringTools;

/**
	This is the main menu state! Not a lot is going to change about it so it'll remain similar to the original, but I do want to condense some code and such.
	Get as expressive as you can with this, create your own menu!
**/
class MainMenu extends MusicBeatState
{
	public var menuItems:FlxTypedGroup<FlxSprite>;

	public static var curSelected:Float = 0;

	public var bg:FlxSprite;
	public var cursorSpr:FlxSprite;
	public var camFollow:FlxObject;

	public var camGame:FlxCamera;
	public var camHUD:FlxCamera;

	public var optionShit:Array<String> = ['Story Mode', 'Freeplay', 'Credits', 'Options'];
	public var chars:Array<String> = ['Abi', 'BF', 'GF', 'A'];

	public var forceCenter:Bool = false;

	public var menuItemScale:Float = 0.7;

	public var char:FNFSprite;
	public var abiOut:FNFSprite;

	var randomChar:Int = 1;

	function setCameras()
	{
		camGame = new FlxCamera();
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camHUD, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);
	}

	override function create()
	{
		super.create();

		randomChar = FlxG.random.int(0, 3);

		// make sure the music is playing
		ForeverTools.resetMenuMusic();

		#if DISCORD_RPC
		Discord.changePresence('MENU SCREEN', 'Main Menu');
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		// uh
		persistentUpdate = persistentDraw = true;

		setCameras();

		bg = new FlxSprite(-180, 0).loadGraphic(Paths.image('menus/fitdon/main/main menu bg'));
		bg.scrollFactor.set(0, 0);
		//bg.setGraphicSize(Std.int(bg.width * 1.2));
		bg.updateHitbox();
		//bg.screenCenter();
		bg.antialiasing = !Init.getSetting('Disable Antialiasing');
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var maxLength:Float = 58 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(100, (i * 160) + maxLength);
			menuItem.frames = Paths.getSparrowAtlas('menus/fitdon/main/' + optionShit[i].toLowerCase() + ' button');

			menuItem.scale.set(menuItemScale, menuItemScale);

			menuItem.animation.addByPrefix('idle', 'mm ' + optionShit[i] + " button", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;

			/*
			//if (forceCenter)
			//	menuItem.screenCenter(X);
			if (menuItem.ID % 2 == 0)
				menuItem.x += 1000;
			else
				menuItem.x -= 1000;
			*/

			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if (optionShit.length < 6)
				scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = !Init.getSetting('Disable Antialiasing');
			menuItem.updateHitbox();
		}
		cursorSpr = new FlxSprite(50, 0).loadGraphic(Paths.image('menus/fitdon/main/menu cursor'));
		cursorSpr.scrollFactor.set(0, 0);
		cursorSpr.updateHitbox();
		add(cursorSpr);

		generateChar(randomChar);

		var camLerp = Main.framerateAdjust(0.10);
		FlxG.camera.follow(camFollow, null, camLerp);

		updateSelection();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (!selectedSomethin)
		{
			if (controls.BACK || FlxG.mouse.justPressedRight)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'), 0.4);
				Main.switchState(this, new TitleState());
			}

			if (controls.CHEAT)
			{
				persistentUpdate = false;
				persistentDraw = true;
				openSubState(new states.substates.EditorMenuSubstate(false));
			}

			var controlArray:Array<Bool> = [
				controls.UI_UP,
				controls.UI_DOWN,
				controls.UI_UP_P,
				controls.UI_DOWN_P,
				FlxG.mouse.wheel == 1,
				FlxG.mouse.wheel == -1
			];
			if ((controlArray.contains(true)))
			{
				for (i in 0...controlArray.length)
				{
					if (controlArray[i] == true)
					{
						if (i > 1)
						{
							if (i == 2 || i == 4)
								curSelected--;
							else if (i == 3 || i == 5)
								curSelected++;

							if (i == 2 || i == 3)
								FlxG.sound.play(Paths.sound('scrollMenu'));
						}
						if (curSelected < 0)
							curSelected = optionShit.length - 1;
						else if (curSelected >= optionShit.length)
							curSelected = 0;
					}
				}
			}

			if (controls.ACCEPT)
			{
				//
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));

				var flickerVal:Float = 0.06;

				if (Init.getSetting('Disable Flashing Lights'))
					flickerVal = 1;

				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						FlxTween.tween(spr, {alpha: 0, x: FlxG.width * 2}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
						});
					}
					else
					{
						FlxFlicker.flicker(spr, 1, flickerVal, false, false, function(flick:FlxFlicker)
						{
							switch (optionShit[Math.floor(curSelected)].toLowerCase())
							{
								case 'story mode':
									FlxTween.tween(spr, {alpha: 0, x: FlxG.width * 2}, 0.4, {
										ease: FlxEase.quadOut,
										onComplete: function(twn:FlxTween)
										{
											
											spr.kill();
										}
									});

									FlxTween.tween(cursorSpr, {alpha: 0, x: FlxG.width * 2}, 0.4, {
										ease: FlxEase.quadOut,
										onComplete: function(twn:FlxTween)
										{
											cursorSpr.kill();
										}
									});

									FlxTween.tween(char, {alpha: 0}, 0.4, {
										ease: FlxEase.quadOut,
										onComplete: function(twn:FlxTween)
										{
											char.kill();
										}
									});

									FlxTween.tween(bg, {alpha: 0}, 0.4, {
										ease: FlxEase.quadOut,
										onComplete: function(twn:FlxTween)
										{
											bg.kill();
											enterWeek1();
										}
									});

								case 'freeplay':
									Main.switchState(this, new FreeplayFatdon());
								case 'credits':
									Main.switchState(this, new CreditsMenu());
								case 'options':
									PauseSubstate.toOptions = false;
									transIn = FlxTransitionableState.defaultTransIn;
									transOut = FlxTransitionableState.defaultTransOut;
									Main.switchState(this, new OptionsMenu());
							}
						});
					}
				});
			}
		}

		if (Math.floor(curSelected) != lastCurSelected)
			updateSelection();

		super.update(elapsed);

		menuItems.forEach(function(menuItem:FlxSprite)
		{
			if (menuItem.ID == curSelected)
				cursorSpr.y = menuItem.y + 20;
			if (forceCenter)
				menuItem.screenCenter(X);
		});
	}

	var lastCurSelected:Int = 0;

	function generateChar(rand:Int)
	{
		char = new FNFSprite(425, 0);
		char.frames = Paths.getSparrowAtlas('menus/fitdon/main/menu ' + chars[rand].toLowerCase());
		char.animation.addByPrefix("idle", chars[rand] + " main menu", 24);
		char.animation.play('idle');
		char.scrollFactor.set(0, 0);
		char.scale.set(0.5, 0.5);
		char.updateHitbox();
		char.screenCenter(Y);
		char.x += 270;
		add(char);

		abiOut = new FNFSprite(0, 900);
		abiOut.frames = Paths.getSparrowAtlas('menus/fitdon/main/abi week 1 groove');
		abiOut.animation.addByPrefix("idle", "Abi story mode", 24);
		abiOut.animation.play('idle');
		abiOut.scrollFactor.set(0, 0);
		abiOut.scale.set(0.5, 0.5);
		abiOut.updateHitbox();
		abiOut.screenCenter(X);
		add(abiOut);
	}
	
	function enterWeek1()
	{
		PlayState.storyPlaylist = ['Hushed', 'Forewarn', 'Downward-Spiral'];
		PlayState.isStoryMode = true;

		var diffic:String = CoolUtil.returnDifficultySuffix(0);
		PlayState.storyDifficulty = 0;

		PlayState.SONG = Song.loadSong(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
		PlayState.storyWeek = 0;
		PlayState.campaignScore = 0;
		Conductor.playbackRate = 1;

		FlxG.sound.music.fadeOut(1);
		FlxTween.tween(abiOut, {y: Math.floor(FlxG.height / 2) - 250}, 1, {
			ease: FlxEase.quadOut,
			onComplete: function(twn:FlxTween)
			{
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					Main.switchState(this, new PlayState());
				});
			}});
	}
	function updateSelection()
	{
		// reset all selections
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			menuItems.members[Math.floor(curSelected)].scale.set(menuItemScale, menuItemScale);
		});

		var itemLength:Float = 0;
		if (menuItems.length > 4)
			itemLength = menuItems.length * 8;

		// set the sprites and all of the current selection
		camFollow.setPosition(menuItems.members[Math.floor(curSelected)].getGraphicMidpoint().x,
			menuItems.members[Math.floor(curSelected)].getGraphicMidpoint().y - itemLength);

		menuItems.members[Math.floor(curSelected)].updateHitbox();

		lastCurSelected = Math.floor(curSelected);
	}
}
