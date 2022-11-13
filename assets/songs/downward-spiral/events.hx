function postCreate()
{
	FlxG.camera.fade(ForeverTools.returnColor('black'), 0.01, false);
}

function stepHit(curStep:Int)
{
	switch (curStep)
	{
		case 1:
			FlxG.camera.fade(ForeverTools.returnColor('black'), 4.5, true);
		case 1093:
			dad.playAnim('transformation', true);
		case 1120:
			PlayState.externalCamY = 280;
		case 1493:
			PlayState.externalCamY = 0;
		case 1494:
			dad.playAnim('turn back', true);
		case 1920:
			FlxG.camera.fade(ForeverTools.returnColor('black'), 1, false);
	}
}