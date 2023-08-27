function postCreate()
{
    var epicShader:FlxRuntimeShader = new FlxRuntimeShader(File.getContent(Paths.frag('bloom')));
    FlxG.camera.setFilters([new ShaderFilter(epicShader)]);
    //PlayState.camHUD.setFilters([new ShaderFilter(epicShader)]);
	//for (hud in PlayState.strumHUD)
	//	hud.setFilters([new ShaderFilter(epicShader)]);
}