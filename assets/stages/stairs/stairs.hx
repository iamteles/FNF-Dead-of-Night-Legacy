function generateStage()
{
    curStage = 'stairs';
    PlayState.defaultCamZoom = 0.6;

	var georgeWBush:FNFSprite = new FNFSprite(500, -200).loadGraphic(Paths.image('bush', 'stages/' + curStage));
	georgeWBush.antialiasing = true;
	georgeWBush.scrollFactor.set(0.6, 0.6);
	georgeWBush.active = false;
	add(georgeWBush);

    var bg:FNFSprite = new FNFSprite(-400, -200).loadGraphic(Paths.image('stairs', 'stages/' + curStage));
    bg.antialiasing = true;
    bg.scrollFactor.set(1, 1);
    bg.active = false;
    add(bg);

	var wall:FNFSprite = new FNFSprite(-600, -200).loadGraphic(Paths.image('wall', 'stages/' + curStage));
	wall.antialiasing = true;
	wall.scrollFactor.set(0.7, 0.7);
	wall.active = false;
	foreground.add(wall);
}

function repositionPlayers(boyfriend:Character, gf:Character, dad:Character)
{
    gf.visible = false;

	dad.x -= 470;
	//dad.y += 190;

	boyfriend.x -= 1100;
	boyfriend.y -= 380;

    /*
	//boyfriend.x += 200;
    boyfriend.y -= 120;

    //gf.x += 200;
    gf.y -= 140;
    */
}
