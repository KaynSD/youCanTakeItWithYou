package state 
{	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import screens.GameOverScreen;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class LevelEndState extends FlxState 
	{
		
		public function LevelEndState() 
		{
			
		}
		
		override public function create():void 
		{	
			FlxG.switchState(new MenuState(GameOverScreen));
		}
	}

}