Handlebars = require('handlebars')
_ = require('underscore')
helpers = {
  escape: (content) ->
    console.log("escape "+_.escape(content))
    _.escape(content)
  parseJSON: (content,options) ->
    options.fn(JSON.parse(content) or {})
  map: (value,into,options) ->
    unless options
      options = into
      into = undefined
    mapping = options.hash
    mapped = mapping[value] or value    
    if into
      @[into] = mapped
      output = undefined
    else
      output = mapped
  addToContext: (options) ->
    values = options.hash or {}
    for name,value in values
      @[name]=value
    options.fn(@)
  debug:(content,options) ->
    console.log('this: '+JSON.stringify(this))
    console.log('content: '+JSON.stringify(content))
    console.log('options: '+JSON.stringify(options))
    output = undefined
}

module.exports = helpers
