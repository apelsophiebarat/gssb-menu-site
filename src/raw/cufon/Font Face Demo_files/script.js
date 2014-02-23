
function rendersNiceFontface() {
	result = navigator.appVersion.indexOf("Win") != -1 
		|| navigator.appVersion.indexOf("Android") != -1;
	return result;
}

var supportsNiceFontface = !rendersNiceFontface();

Modernizr.load([
	{
		test : Modernizr.fontface && Modernizr.canvas && supportsNiceFontface,
		
		nope : [ 'cufon-yui.js', 'BebasNeueRegular_400.font.js', 'cufon-polyfill.js' ]
	}
])
