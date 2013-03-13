package model 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author LoneWolfWilliams
	 */
	public class FontLibrary 
	{
		[Embed(source="../../embedded/Crimson/Crimson-Italic.otf", 
			fontName = "Crimson", 
			mimeType = "application/x-font", 
			fontWeight="normal", 
			fontStyle="italic", 
			//unicodeRange="englishRange", 
			advancedAntiAliasing="true", 
			embedAsCFF="false")]
		public static var CrimsonFont:Class;
		
		public static function createTextFormat():TextFormat
		{
			var format:TextFormat = new TextFormat("Crimson", 100);
			format.align = TextFormatAlign.CENTER;
			format.color = 0xFFFFFF;
			
			return format;
		}
		
		public static function CreateTextfield():TextField
		{
			var field:TextField = new TextField();
			field.embedFonts = true;
			field.autoSize = TextFieldAutoSize.CENTER;
			field.selectable = false;
			
			return field;
		}
	}

}