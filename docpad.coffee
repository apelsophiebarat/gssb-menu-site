# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
  templateData:
    site:
      googleanalytics:
        account: 'UA-XXXXX-X'
      year: "2013"
      company: "Company"
      title: "Title here"
      description: "description here"
      projectName: "Project Name"
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
    grunt:
      docpadReady: ['bower:install']
      writeAfter: false
  collections:
    navigationPages: ->
      @getCollection("html").findAll({navigation:true},[{navigationOrder:1}])
}

# Export the DocPad Configuration
module.exports = docpadConfig