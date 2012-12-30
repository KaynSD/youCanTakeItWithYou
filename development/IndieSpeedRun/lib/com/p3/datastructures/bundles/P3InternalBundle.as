package com.p3.datastructures.bundles 
{
	import com.greensock.events.LoaderEvent;
	import flash.events.Event;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
	[Event(name = "complete", type = "com.greensock.events")]
	
	/**
	 * ...
	 * @author Duncan Saunders
	 */
	public class P3InternalBundle extends P3AssetBundle
	{
				
		public function P3InternalBundle() 
		{
			super();
			m_name = "P3InternalBundle";
		}
		
		override public function load():void 
		{
			 // Get information about our members (which will be embedded resources)
            var desc:XML = describeType(this);
            var res:Class;
            var resIsEmbedded:Boolean;
            var resSource:String;
            var resMimeType:String;
            var resTypeName:String;
            
            // Loop through each public variable in this class
            for each (var v:XML in desc.variable)
            {
                // Store a reference to the object
                res = this[v.@name];
				// Assume that it is not properly embedded, so that we can throw an error if needed.
                resIsEmbedded = false;
                resSource = "";
                resMimeType = "";
                resTypeName="";
                
                // Loop through each metadata tag in the child variable
                for each (var meta:XML in v.children())
                {
                    // If we've got an embedded metadata
                    if (meta.@name == "Embed") 
                    {
                        // If we've got a valid embed tag, then the resource embedded correctly.
                        resIsEmbedded = true;
                        
                        // Extract the source and MIME information from the embed tag.
                        for each (var arg:XML in meta.children())
                        {
                            if (arg.@key == "source") 
                            {
                                resSource = arg.@value;
                            } 
                            else if (arg.@key == "mimeType") 
                            {
                                resMimeType = arg.@value;
                            }
                        }
                    }
                    else if (meta.@name == "ResourceType")
                    {
                        for each (arg in meta.children())
                        {
                            if (arg.@key == "className") 
                            {
                                resTypeName = arg.@value;
                            } 
                        }                  
                    }
                }
                
                // Now that we've processed all of the metadata, it's time to see if it embedded properly.
                
                // Sanity check:
                if ( !resIsEmbedded || resSource == "" || res == null ) 
                {
                    log("source :" + resSource);
					log( "ResourceBundle - " + "A resource in the resource bundle with the name '" + v.@name + "' has failed to embed properly.  Please ensure that you have the command line option \"--keep-as3-metadata+=TypeHint,EditorData,Embed\" set properly.  Additionally, please check that the [Embed] metadata syntax is correct.");
					trace( "ResourceBundle - "+ "A resource in the resource bundle with the name '" + v.@name + "' has failed to embed properly.  Please ensure that you have the command line option \"--keep-as3-metadata+=TypeHint,EditorData,Embed\" set properly.  Additionally, please check that the [Embed] metadata syntax is correct.");
                    continue;
                }
                
                // If a metadata tag isn't specified with the resource type name explicitly,
                if (resTypeName == "")
                {
                    // Then look up the class name by extension (this is the default behavior).
                    
                    // Get the extension of the source filename
                    var extArray:Array = resSource.split(".");
                    var ext:String = (extArray[extArray.length-1] as String).toLowerCase();
                   
                }
                
                // Now that we (hopefully) have our resource type name, we can try to instantiate it.
                var resType:Class;
                try 
                {
                    // Look up the class!
                    resType = getDefinitionByName( resTypeName ) as Class;
                } 
                catch ( err:Error ) 
                {
                    // Failed, so make sure it's null.
                    resType = null;
                }
                
                //if (!resType)
                //{
                   //trace("ResourceBundle", "The resource type '" + resTypeName + "' specified for the embedded asset '" + resSource + "' could not be found.  Please ensure that the path name is correct, and that the class is explicity referenced somewhere in the project, so that it is available at runtime.  Do you call PBE.registerType(" + resTypeName + "); somewhere?");
                    //continue;
                //}
				
				//Core.lib.registerInternalAsset(resSource, res)
				registerAsset(resSource, res);
                //EmbeddedResourceProvider.instance.registerResource( resSource, resType, new res() );
            }
			onLoadComplete();
		}
		
	}

}