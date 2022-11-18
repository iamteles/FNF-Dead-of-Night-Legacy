function generateStage()
{
  curStage = 'hill';
  PlayState.defaultCamZoom = 0.4;

  var bg:FNFSprite = new FNFSprite(-600, -200).loadGraphic(Paths.image('sky', 'stages/' + curStage));
  bg.antialiasing = true;
  bg.scrollFactor.set(0.4, 0.4);
  bg.active = false;
  add(bg);

  var grass:FNFSprite = new FNFSprite(-600, -200).loadGraphic(Paths.image('grass', 'stages/' + curStage));
  grass.antialiasing = true;
  grass.scrollFactor.set(1, 1);
	grass.active = false;
	add(grass);
}

function repositionPlayers(boyfriend:Character, gf:Character, dad:Character)
{
  /*
  dad.x -= 720;
  dad.y -= 90; 
	//boyfriend.x += 200;
  boyfriend.y -= 120;
  //gf.x += 200;
  gf.y -= 140;
  */
}
