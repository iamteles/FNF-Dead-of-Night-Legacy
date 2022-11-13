package funkin.userInterface;

import base.Conductor;
import base.CoolUtil;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import states.PlayState;

using StringTools;

class ClassHUD extends FlxTypedGroup<FlxBasic>
{
	// set up variables and stuff here
	public var scoreBar:FlxText;

	var scoreColorTween:FlxTween;

	public var healthBarBG:FlxSprite;
	public var healthBar:FlxBar;

	public var iconP1:HealthIcon;
	public var iconP2:HealthIcon;

	public var infoDisplay:String = CoolUtil.dashToSpace(PlayState.SONG.song);
	public var diffDisplay:String = CoolUtil.difficultyFromString();
	public var engineDisplay:String = "F.E. UNDERSCORE v" + Main.engineVersion + (Main.nightly ? '-NIGHTLY' : '');

	public var autoplayMark:FlxText;
	public var autoplaySine:Float = 0;

	var timingsMap:Map<String, FlxText> = [];

	private var barFillDir = RIGHT_TO_LEFT;

	private final barPlayer = FlxColor.fromRGB(PlayState.boyfriend.characterData.barColor[0], PlayState.boyfriend.characterData.barColor[1],
		PlayState.boyfriend.characterData.barColor[2]);
	private final barEnemy = FlxColor.fromRGB(PlayState.dad.characterData.barColor[0], PlayState.dad.characterData.barColor[1],
		PlayState.dad.characterData.barColor[2]);

	var vgblack:FlxSprite;

	public function new()
	{
		super();

		vgblack = new FlxSprite().loadGraphic(Paths.image('UI/black-vignette'));
		add(vgblack);

		switch(PlayState.SONG.song.toLowerCase())
		{
			case "hushed":
				vgblack.alpha = 0.4;
			case "forewarn":
				vgblack.alpha = 0.7;
			case "downward-spiral":
				vgblack.alpha = 1;
			default:
				vgblack.alpha = 0;
		}

		// le healthbar setup
		var barY = FlxG.height * 0.875;
		if (Init.getSetting('Downscroll'))
			barY = 64;

		healthBarBG = new FlxSprite(0, barY);
		healthBarBG.loadGraphic(Paths.image(ForeverTools.returnSkin('healthBar', PlayState.assetModifier, PlayState.uiModifier, 'UI')));

		healthBarBG.screenCenter(X);
		healthBarBG.scrollFactor.set();
		add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, barFillDir, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8));
		healthBar.scrollFactor.set();
		updateBar();

		// healthBar
		add(healthBar);

		var healthBarOverlay:FlxSprite = new FlxSprite(0, barY).loadGraphic(Paths.image('UI/healthBarOverlay'));
		healthBarOverlay.screenCenter(X);
		healthBarOverlay.scrollFactor.set();
		healthBarOverlay.blend = ADD;
		healthBarOverlay.alpha = 0.3;
		add(healthBarOverlay); // thanks diogo

		iconP1 = new HealthIcon(PlayState.boyfriend.characterData.icon, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);
		add(iconP1);

		iconP2 = new HealthIcon(PlayState.dad.characterData.icon, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);
		add(iconP2);

		scoreBar = new FlxText(FlxG.width / 2, Math.floor(healthBarBG.y + 30), 0, '');
		scoreBar.setFormat(Paths.font('prime'), 22, FlxColor.WHITE);
		scoreBar.setBorderStyle(OUTLINE, FlxColor.BLACK, 1.5);
		scoreBar.antialiasing = !Init.getSetting('Disable Antialiasing');
		add(scoreBar);

		autoplayMark = new FlxText(0, (Init.getSetting('Downscroll') ? FlxG.height - 40 : 10), FlxG.width - 800, '[AUTOPLAY]\n', 32);
		autoplayMark.setFormat(Paths.font("prime"), 32, FlxColor.WHITE, CENTER);
		autoplayMark.setBorderStyle(OUTLINE, FlxColor.BLACK, 2);
		autoplayMark.screenCenter(X);
		autoplayMark.visible = PlayState.bfStrums.autoplay;

		// repositioning for it to not be covered by the receptors
		if (Init.getSetting('Centered Receptors'))
		{
			if (Init.getSetting('Downscroll'))
				autoplayMark.y = autoplayMark.y - 125;
			else
				autoplayMark.y = autoplayMark.y + 125;
		}

		add(autoplayMark);


		updateScoreText();
		updateBar();
	}

	public var counterTextSize:Int = 18;
	public var counterTextFont:String = 'prime';

	override public function update(elapsed:Float)
	{
		// pain, this is like the 7th attempt
		healthBar.percent = (PlayState.health * 50);

		var iconOffset:Int = 26;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		iconP1.updateAnim(healthBar.percent);
		iconP2.updateAnim(100 - healthBar.percent);

		if (autoplayMark.visible)
		{
			autoplaySine += 180 * (elapsed / 4);
			autoplayMark.alpha = 1 - Math.sin((Math.PI * autoplaySine) / 80);
		}
	}

	private var divider:String = " • ";

	private var tempScore:String;

	public function updateScoreText()
	{
		var displayAccuracy = Init.getSetting('Display Accuracy');
		var unrated = (Timings.comboDisplay == null || Timings.comboDisplay == '');

		tempScore = 'Score: ${PlayState.songScore}'
			+ (displayAccuracy ? divider + 'Accuracy: ${Std.string(Math.floor(Timings.getAccuracy() * 100) / 100)}%' : '')
			+ (displayAccuracy ? divider + 'Misses: ${PlayState.misses}' : '')
			+ '\n';

		scoreBar.text = tempScore;
		scoreBar.x = Math.floor((FlxG.width / 2) - (scoreBar.width / 2));

		// update playstate
		PlayState.detailsSub = scoreBar.text;
		PlayState.updateRPC(false);
	}

	public function updateBar()
	{
		healthBar.createFilledBar(barEnemy, barPlayer);
		healthBar.scrollFactor.set();
		healthBar.updateBar();
	}

	public function beatHit(curBeat:Int)
	{
		if (!Init.getSetting('Reduced Movements'))
		{
			iconP1.bop(60 / Conductor.bpm);
			iconP2.bop(60 / Conductor.bpm);
		}
	}
}
