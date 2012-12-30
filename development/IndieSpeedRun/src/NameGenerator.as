package  
{
	/**
	 * ...
	 * @author KEvans
	 */
	
	public class NameGenerator
	{
		static public const END_CHAR:String = "!";
		
		private var generatorSeeds:Array
		private var generatorInitials:Array;
		
		public function NameGenerator() 
		{
			super();
			var rootArray:Array = new ListOfNames().toString().split("\r");
			generatorSeeds = new Array();
			generatorInitials = new Array();
			
			for (var i:int = 0; i < rootArray.length; i++) {
				
				var name:String = rootArray[i];
				
				for (var j:int = 0; j < name.length; j++) 
				{
					
					var index:String = name.charAt(j).toLowerCase();
					var nxtChar:String = j == name.length - 1 ? END_CHAR : name.charAt(j + 1).toLowerCase();
					
					if (!generatorSeeds[index]) {
						// Not Already Existing Letter
						
						generatorSeeds[index] = new Array();
						generatorInitials.push(index);
						
					} 
					
					generatorSeeds[index].push(nxtChar);
					
					
				}
				
				
			}
			
		}
		
		public function generateName():String 
		{
			
			var generated:String = "";
			var lastLetter:String = generatorInitials[int(Math.random() * generatorInitials.length)];
			
			if (lastLetter == "" || lastLetter == "-" || lastLetter == "!" || lastLetter == " " || lastLetter == "\n" || lastLetter == "\r") return generateName();
			
			while (true) {
				
				if (lastLetter == END_CHAR) break;
				
				generated += lastLetter;
				
				lastLetter = generatorSeeds[lastLetter][int(generatorSeeds[lastLetter].length * Math.random())]
				
			}
			
			return generated;
		}
		
	}

}