
/**		
 * 
 *	uk.co.soulwire.display.Glitchmap
 *	
 *	@version 1.00 | Feb 2, 2010
 *	@author Justin Windle
 *	@see http://blog.soulwire.co.uk
 *  
 **/
 
package view.glitch 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;
	
	/*
	 * Gareth Williams
	 * slight adaptation
	 */
	 
	public class Glitchmap extends Sprite 
	{
		public static const NULL_BYTE : int = 0;

		//	----------------------------------------------------------------
		//	PRIVATE MEMBERS
		//	----------------------------------------------------------------

		private var _bytesSource : ByteArray;
		private var _bytesGlitch : ByteArray;

		private var _bytesLoader : Loader = new Loader();

		private var _output : Bitmap;

		private var _seed : Number = 1.0;
		private var _headerSize : int = 417;
		private var _maxIterations : int = 512;
		private var _glitchiness : Number = 0.0;

		private var _width:Number;
		private var _height:Number;
		
		//optional factory function
		public static function CreateGlitch(image : ByteArray):Glitchmap
		{
			var glitchedImage:Glitchmap = new Glitchmap();
			glitchedImage.draw(image);
			
			return glitchedImage;
		}
		
		public function draw(image : ByteArray) : void
		{
			//_output = image;
			_bytesSource = image;
			
			if (!_bytesGlitch)
			{
				_bytesGlitch = new ByteArray();
			}
			
			_bytesLoader.unload();
			_bytesSource.position = 0;
			
			_bytesGlitch.length = 0;
			_bytesGlitch.writeBytes(_bytesSource, 0, _bytesSource.bytesAvailable);
			
			if(_glitchiness > 0.0)
			{
				var length : int = _bytesGlitch.length - _headerSize - 2;
				var amount : int = int(_glitchiness * _maxIterations);
				var random : Number = _seed;
				
				for (var i : int = 0;i < amount;i++)
				{
					random = ( random * 16807 ) % 2147483647;
					
					_bytesGlitch.position = _headerSize + int(length * random * 4.656612875245797e-10);
					_bytesGlitch.writeByte(NULL_BYTE);
				}
			}
			
			_bytesLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onBytesLoadError);
			_bytesLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBytesLoaded);
			_bytesLoader.loadBytes(_bytesGlitch);
		}

		//	----------------------------------------------------------------
		//	EVENT HANDLERS
		//	----------------------------------------------------------------

		private function onBytesLoadError(event : IOErrorEvent) : void
		{
			trace(event.text);
		}

		private function onBytesLoaded(event : Event) : void
		{
			if(!_output)
			{
				_output = _bytesLoader.content as Bitmap;
				addChild(_output);
			}
			else
			{
				_output.bitmapData.dispose();
				_output.bitmapData = _bytesLoader.content['bitmapData'];
			}
			
			/*
			_output.width = _width;
			_output.height = _height;
			*/
			
			var hScale:Number = _width / _output.width;
			var vScale:Number = _height / _output.height;
			var scale:Number = Math.abs(hScale) > Math.abs(vScale) ? hScale : vScale;
			
			_output.width *= scale;
			_output.height *= scale;
			
			_output.x = (_width - _output.width) * 0.5;
			_output.y = (_height - _output.height) * 0.5;
			
			_bytesLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onBytesLoadError);
			_bytesLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onBytesLoadError);
			dispatchEvent(new Event(Event.CHANGE));
		}

		private function onLoadIOError(event : IOErrorEvent) : void
		{
			trace("Error");
			dispatchEvent(event);
		}

		//	----------------------------------------------------------------
		//	PUBLIC ACCESSORS
		//	----------------------------------------------------------------

		public function get glitchiness() : Number
		{
			return _glitchiness;
		}

		public function set glitchiness(value : Number) : void
		{
			_glitchiness = value < 0.0 ? 0.0 : value > 1.0 ? 1.0 : value;
			draw(_bytesSource);
		}

		public function get maxIterations() : int
		{
			return _maxIterations;
		}

		public function set maxIterations(value : int) : void
		{
			_maxIterations = value;
			draw(_bytesSource);
		}

		public function get seed() : Number
		{
			return _seed;
		}

		public function set seed(value : Number) : void
		{
			_seed = value;
			draw(_bytesSource);
		}

		public function get bytesSource() : ByteArray
		{
			return _bytesSource;
		}

		public function set bytesSource(value : ByteArray) : void
		{
			_bytesSource = value;
			_bytesSource.position = 0;
			_headerSize = 417;

			var byte : uint;
			
			while(_bytesSource.bytesAvailable)
			{
				byte = _bytesSource.readUnsignedByte();
				
				if(byte == 0xFF)
				{
					byte = _bytesSource.readUnsignedByte();
					
					if(byte == 0xDA)
					{
						_headerSize = _bytesSource.position + _bytesSource.readShort();
						break;
					}
					
					_bytesSource.position--;
				}
			}
			
			draw(_bytesSource);
		}

		public function get bytesGlitch() : ByteArray
		{
			return _bytesGlitch;
		}

		public function get bitmapData() : BitmapData
		{
			return _output.bitmapData;
		}
		
		public override function set width(value:Number) : void
		{
			_width = value;
		}
		public override function get width() : Number
		{
			return _width;
		}
		public override	function set height(value:Number) : void
		{
			_height = value;
		}
		public override function get height() : Number
		{
			return _height;
		}
	}
}
