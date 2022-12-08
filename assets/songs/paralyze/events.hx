var tween:FlxTween;

function postCreate()
{
	PlayState.vignetteHUD.fade(ForeverTools.returnColor('black'), 0.01, false);
	PlayState.dad.alpha = 0.0001;
	//PlayState.defaultCamZoom = 0.4;
	PlayState.scriptDebugMode = true;



	tween = FlxTween.tween(PlayState.dad, {y: PlayState.dad.y - 40}, 1.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
}

function stepHit(curStep:Int)
{
	switch (curStep)
	{
		case 1:
			PlayState.vignetteHUD.fade(ForeverTools.returnColor('black'), 4.5, true);
		case 384:
			FlxTween.tween(PlayState.dad, {alpha: 0.9}, 2, {ease: FlxEase.circOut});
		case 928:
			PlayState.vignetteHUD.fade(ForeverTools.returnColor('black'), 0.3, false);
			tween.cancel();
		case 994:
			PlayState.forceZoom = [0, -0.3, 0, 0];
			tween = FlxTween.tween(PlayState.dad, {y: PlayState.dad.y - 140}, 1.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
		case 1055:
			PlayState.vignetteHUD.fade(ForeverTools.returnColor('black'), 4.5, true);
		case 1567:
			PlayState.updateLyrics("killing ", true);
		case 1573:
			PlayState.updateLyrics("and ", true);
		case 1575:
			PlayState.updateLyrics("killing ", true);
		case 1577:
			PlayState.updateLyrics("and ", false);
		case 1579:
			PlayState.updateLyrics("you ", true);
		case 1581:
			PlayState.updateLyrics("pin it ", true);
		case 1587:
			PlayState.updateLyrics("on ", true);
		case 1591:
			PlayState.updateLyrics("me", false, true);
		case 1597:
			PlayState.updateLyrics("you ", false);
		case 1599:
			PlayState.updateLyrics("drag ", true);
		case 1603:
			PlayState.updateLyrics("me ", true);
		case 1605:
			PlayState.updateLyrics("around", true);
		case 1610:
			PlayState.updateLyrics("i ", false);
		case 1612:
			PlayState.updateLyrics("just ", true);
		case 1615:
			PlayState.updateLyrics("want ", true);
		case 1619:
			PlayState.updateLyrics("to be", false);
		case 1623:
			PlayState.updateLyrics("free", false);
		case 1629:
			PlayState.updateLyrics("i dont ", false);
		case 1632:
			PlayState.updateLyrics("wanna ", true);
		case 1636:
			PlayState.updateLyrics("see ", true);
		case 1639:
			PlayState.updateLyrics("anymore", true);
		case 1647:
			PlayState.updateLyrics("people", false);
		case 1651:
			PlayState.updateLyrics("people", false, true);
		case 1655:
			PlayState.updateLyrics("dead", false, true);
		case 1660:
			PlayState.updateLyrics("get out of my head", false);
		case 1677:
			PlayState.updateLyrics("GET OUT OF MY HEAD", false, true);
		case 1700:
			PlayState.updateLyrics("", false);
	}
}