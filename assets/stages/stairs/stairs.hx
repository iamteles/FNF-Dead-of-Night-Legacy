function generateStage()
{
    curStage = 'stairs';
    PlayState.defaultCamZoom = 0.8;

    var bg:FNFSprite = new FNFSprite(-600, -200).loadGraphic(Paths.image('stairs', 'stages/' + curStage));
    bg.antialiasing = true;
    bg.scrollFactor.set(1, 1);
    bg.active = false;
    add(bg);
}

function repositionPlayers(boyfriend:Character, gf:Character, dad:Character)
{
    gf.visible = false;
    /*
	//boyfriend.x += 200;
    boyfriend.y -= 120;
    dad.x -= 220;
    dad.y += 190;
    //gf.x += 200;
    gf.y -= 140;
    */
}
