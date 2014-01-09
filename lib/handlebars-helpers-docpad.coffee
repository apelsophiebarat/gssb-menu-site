module.exports = {
	partial:(partialName, additional...) ->
		additional.pop() # remove the hash object
		output = @partial(partialName, additional)
	getBlock: (type, additional...) ->
		additional.pop() # remove the hash object
		output = @getBlock(type).add(additional).toHTML()
	eachCollection: (collectionName, options) ->
		if options and options.fn
			collection = @getCollection(collectionName).toJSON()
			elements = for item in collection then options.fn(item,{data:@})
			output = elements.join(' ')
	parseContentAsJSON: (options) ->
		@content = JSON.parse(@content)
		options.fn(@)
}
