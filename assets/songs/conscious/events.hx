function postCreate()
{
	FlxG.camera.fade(ForeverTools.returnColor('black'), 0.01, false);
}

function stepHit(curStep:Int)
{
	switch (curStep)
	{
		case 1:
			FlxG.camera.fade(ForeverTools.returnColor('black'), 2.3, true);
		case 256:
			FlxG.camera.fade(ForeverTools.returnColor('black'), 1, false);
		case 310:
			PlayState.defaultCamZoom = 0.4;
		case 320:
			FlxG.camera.fade(ForeverTools.returnColor('black'), 0.5, true);
	}
}