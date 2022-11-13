package shaders; 

/*
    This exists solely because im an idiot. - teles
*/
import flixel.FlxG;
import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import shaders.*;

class Shaders
{
	public static var chromaticAberration:ShaderFilter = new ShaderFilter(new ChromaticAberration());
	public static var vignette:ShaderFilter = new ShaderFilter(new Vignette());
	private static var vignetteLerp:Float = 0;

	public static function setChrome(?chromeOffset:Float):Void
	{
		chromaticAberration.shader.data.rOffset.value = [chromeOffset];
		chromaticAberration.shader.data.gOffset.value = [0.0];
		chromaticAberration.shader.data.bOffset.value = [chromeOffset * -1];
	}

	public static function setVignette(?radius:Float):Void
	{
		vignette.shader.data.radius.value = [radius];
		if (vignette.shader.data.radius.value == null)
			vignette.shader.data.radius.value = [0];
		vignetteLerp = CoolUtil.utilityLerp(vignetteLerp, radius, 0.075);
		if (Math.abs(vignetteLerp - radius) <= 0.01)
			vignetteLerp = radius;
		vignette.shader.data.radius.value = [vignetteLerp];
	}
}