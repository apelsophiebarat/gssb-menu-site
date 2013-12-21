merge = require('./coffee-helpers').merge

injector = {
  injectHelpers: (docpadConfig,helpers) ->
    if docpadConfig?.plugins?.handlebars
      pluginConfig = docpadConfig.plugins.handlebars
      pluginHelpers = pluginConfig.helpers or {}
      pluginConfig['helpers'] = merge(pluginHelpers,helpers)
}

module.exports = injector


