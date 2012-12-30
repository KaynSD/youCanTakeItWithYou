package base.interfaces 
{
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public interface ISerializedObject 
	{
		function serialize ():XML;
		function deserialize ($xml:XML):void;
	}
	
}