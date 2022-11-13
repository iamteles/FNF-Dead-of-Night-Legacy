function generateStage()
{
    curStage = 'street';
    PlayState.defaultCamZoom = 0.8;

    var bg:FNFSprite = new FNFSprite(-600, -200).loadGraphic(Paths.image('image', 'stages/' + curStage));
    bg.antialiasing = true;
    bg.scrollFactor.set(1, 1);
    bg.active = false;
    add(bg);
}

function repositionPlayers(boyfriend:Character, gf:Character, dad:Character)
{
    if(PlayState.SONG.player2.toLowerCase() == "a")
    {
		dad.x -= 820;
		dad.y -= 90;
    }
    else
    {
		dad.x -= 720;
		dad.y -= 90;
    }
        
	//boyfriend.x += 200;
    boyfriend.y -= 120;
    //gf.x += 200;
    gf.y -= 140;
}
