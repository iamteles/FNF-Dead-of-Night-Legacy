function generateStage()
{
    //PlayState.defaultCamZoom = 0.8;

    var bg:FNFSprite = new FNFSprite(-600, -200).loadGraphic(Paths.image('darkness', 'stages/darkness'));
    bg.antialiasing = true;
    bg.scrollFactor.set(1, 1);
    bg.active = false;
    add(bg);

	var handleft:FNFSprite = new FNFSprite(-600, 0);
	handleft.frames = Paths.getSparrowAtlas('bg hand left', 'stages/darkness');
	handleft.animation.addByPrefix("idle", "bg hand left", 24);
	handleft.animation.play('idle');
	FlxTween.tween(handleft, {x: -400}, 1.6, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
    foreground.add(handleft);

	var handright:FNFSprite = new FNFSprite(1100, 0);
	handright.frames = Paths.getSparrowAtlas('bg hand right', 'stages/darkness');
	handright.animation.addByPrefix("idle", "bg hand right", 24);
	handright.animation.play('idle');
	FlxTween.tween(handright, {x: 900}, 1.6, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
	foreground.add(handright);
}

function repositionPlayers(boyfriend:Character, gf:Character, dad:Character)
{
    gf.visible = false;

	boyfriend.x -= 400;
	boyfriend.y += 120;

	dad.x -= 360;
	dad.y -= 190;
}
