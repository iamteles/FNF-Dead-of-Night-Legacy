function stepHit(curStep:Int)
{
	switch (curStep)
	{
		case 2:
			PlayState.defaultCamZoom = 1.05;
		// FlxTween.tween(vignetteHUD, {alpha: 1}, 0.5);
		case 255: // 256
			PlayState.beatSpeed = 2;
			PlayState.beatZoom = 0.04;
		case 416:
			PlayState.beatSpeed = 8;
			PlayState.beatZoom = 0.04;
			PlayState.defaultCamZoom = 1.12;
		case 447:
			PlayState.beatSpeed = 2;
			PlayState.beatZoom = 0.04;
		case 480:
			PlayState.defaultCamZoom = 0.9;
		case 512:
			PlayState.beatSpeed = 4;
			PlayState.beatZoom = 0;
			PlayState.defaultCamZoom = 1.15;
		case 576:
			PlayState.defaultCamZoom = 1.2;
		case 640:
			PlayState.beatSpeed = 2;
			PlayState.beatZoom = 0.04;
			PlayState.defaultCamZoom = 1.05;
		case 768:
			PlayState.beatSpeed = 4; // add vignette here
			PlayState.defaultCamZoom = 1.15;

		case 832:
			PlayState.beatSpeed = 2;
			PlayState.defaultCamZoom = 1.05;
		case 896:
			PlayState.beatSpeed = 4;
			PlayState.beatZoom = 0;
			PlayState.defaultCamZoom = 1.2;
		case 912:
			PlayState.defaultCamZoom = 0.9;
		case 1040:
			PlayState.defaultCamZoom = 0.8;
	}
}