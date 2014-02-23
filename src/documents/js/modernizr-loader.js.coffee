loadRespondOnDemand =
	test: Modernizr.mq('only all')
	nope: 'js/plugins/respond.js?v=v1.1'

loadJQueryFromCDNIfPossible =
	load: 'https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js'
	complete: () -> window.jQuery || Modernizr.load('js/libs/jquery.js?v=1.7.2')

Modernizr.load [loadRespondOnDemand,loadJQueryFromCDNIfPossible]

