package entities.blocks 
{
	import entities.DynamicEntity;
	import entities.Entity;
	import entities.Player;
	import org.flixel.FlxG;
	import world.World;
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class Block extends DynamicEntity
	{
		
		private var _death_particle_x_force:int;

		public function Block(X:Number = 0, Y:Number = 0) 
		{
			super(X, Y);
		}
		
		override public function init($world:World):void 
		{
			_player = $world.player;
			super.init($world);
		}
		
		override public function reset(X:Number, Y:Number):void 
		{
			super.reset(_start_x, _start_y);
			frame = 0;
		}
		
		override public function hurt(Damage:Number):void 
		{
			_death_particle_x_force = Damage * 2
			if (Damage < 0) Damage *= -1;
			super.hurt(Damage);
		}
		
		override public function clone():Entity 
		{
			return new Block ();
		}
		
	}

}