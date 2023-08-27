function generateStage()
{
    //PlayState.defaultCamZoom = 0.8;

    var bg:FNFSprite = new FNFSprite(-600, -200).loadGraphic(Paths.image('alley', 'stages/alleyway'));
    bg.antialiasing = true;
    bg.scrollFactor.set(1, 1);
    bg.active = false;
    add(bg);

	var wall:FNFSprite = new FNFSprite(-600, 800).loadGraphic(Paths.image('foreground brain', 'stages/alleyway'));
	wall.antialiasing = true;
	wall.scrollFactor.set(0.4, 0.4);
	wall.active = false;
	foreground.add(wall);

	var head:FNFSprite = new FNFSprite(1200, 800).loadGraphic(Paths.image('foreground head', 'stages/alleyway'));
	head.antialiasing = true;
	head.scrollFactor.set(0.4, 0.4);
	head.active = false;
	foreground.add(head);
}

function repositionPlayers(boyfriend:Character, gf:Character, dad:Character)
{
    gf.visible = false;

	boyfriend.y += 180;
	boyfriend.x -= 350;

	dad.x -= 280;

    /*
	//boyfriend.x += 200;
    boyfriend.y -= 120;
    dad.x -= 220;
    dad.y += 190;
    //gf.x += 200;
    gf.y -= 140;
    */
}
