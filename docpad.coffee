# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
  templateData:
    site:
      googleanalytics:
        account: 'UA-XXXXX-X'
      disqus:
        shortname: 'apelgssb'
      year: "2013"
      company: "Apel Sophie Barat"
      title: "Apel Sophie Barat"
      description: "Apel Sophie Barat - Application Menu Restauration"
      projectName: "Apel Sophie Barat"
      outdatedWarning: """
      Votre version de navigateur <strong>n'est pas à jour</strong>.
       Veuillez <a href="http://browsehappy.com/">installer une version
       plus récente</a> de votre navigateur ou
       <a href="http://www.google.com/chromeframe/?redirect=true">
       installer le plugin Google Chrome Frame</a>
       pour améliorer votre navigation sur internet.
      """
  watchOptions:
    preferredMethods: ['watchFile','watch']
	plugins:
    emailobfuscator:
        emailAddresses:
            restauration: "commission.restauration@apelsophiebarat.net"
    #handlebars plugin configuration
    handlebars:
      helpers:
        getStylesBlock: () ->
          output = @getBlock('styles').add(@document.styles or []).toHTML()
        # Expose docpads 'getBlock' function to handlebars
        isCurrentPage: (pageId, options) ->
          documentId = options.data?.document?.id
          output = if pageId is documentId then 'active' else 'inactive'
      partials:
        title: '<h1>{{document.title}}</h1>'
        goUp: '<a href="#">Scroll up</a>'
    #grunt plugin configuration
    grunt:
      docpadReady: ['bower:install']
      writeAfter: false
  collections:
    navigationPages: ->
      @getCollection("html").findAll({navigation:true},[{navigationOrder:1}])
}

injector = require('./lib/handlebars-helpers-injector')
commonHelpers = require('./lib/handlebars-helpers-common')
docpadHelpers = require('./lib/handlebars-helpers-docpad')
restaurationHelpers = require('./lib/restauration').helpers
injector.injectHelpers(docpadConfig,commonHelpers)
injector.injectHelpers(docpadConfig,docpadHelpers)
injector.injectHelpers(docpadConfig,restaurationHelpers)

# Export the DocPad Configuration
module.exports = docpadConfig
