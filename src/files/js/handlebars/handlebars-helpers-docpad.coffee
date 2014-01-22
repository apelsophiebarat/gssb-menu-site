module.exports = {
  partial:(partialName, options) ->
    if options
      additional = options.hash or {}
      includeTemplateData = additional.includeTemplateData or true
      if(includeTemplateData)
        output = @partial(partialName, additional)
      else
        output = @partial(partialName, false, additional)
  getBlock: (type, options) ->
    if options
      additional = options.hash or {}
      values = value for key,value of additional
      values or= []
      output = @getBlock(type).add(values).toHTML()
  eachCollection: (collectionName, options) ->
    if options and options.fn
      collection = @getCollection(collectionName)
      throw "eachCollection hbs directive error : collection #{collectionName} not found" unless collection?
      collection = collection.toJSON()
      elements = for item in collection then options.fn(item,{data:@})
      output = elements.join(' ')
  parseContentAsJSON: (options) ->
    @content = JSON.parse(@content)
    options.fn(@)
}
