module.exports =
  helpers:
    partial:(partialName, options) ->
      throw "partial need the partial name has parameter" unless options?
      additional = options.hash or {}
      includeTemplateData = additional.includeTemplateData or true
      if(includeTemplateData)
        output = @partial(partialName, additional)
      else
        output = @partial(partialName, false, additional)

    getBlock: (type, options) ->
      throw "getBlock need the block type to return" unless options?
      additional = options.hash or {}
      values = value for key,value of additional
      values or= []
      output = @getBlock(type).add(values).toHTML()

    getCollection: (collectionName, options) ->
      collection = @getCollection(collectionName)
      throw "eachCollection hbs directive error : collection #{collectionName} not found" unless collection?
      collection = collection.toJSON()

    eachCollection: (collectionName, options) ->
      if options? and options.fn?
        collection = @getCollection(collectionName)
        throw "eachCollection hbs directive error : collection #{collectionName} not found" unless collection?
        collection = collection.toJSON()
        elements = for item in collection then options.fn(item,{data:@})
        output = elements.join(' ')
      else
        output = []

    parseContentAsJSON: (options) ->
      @content = JSON.parse(@content)
      options.fn(@)
