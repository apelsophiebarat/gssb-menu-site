# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
_ = require 'lodash'

module.exports =
  templateData:
    site:
      url: 'http://apelsophiebarat.net'
      services:
        disqus: 'apelgssb'
        googleAnalytics: 'UA-XXXXX-X'
      year: "2014"
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
    mailchimp:
        correspondantsRestauration:
          action: 'http://apelsophiebarat.us3.list-manage.com/subscribe/post?u=09c087e63bef0442598264fcc&id=8951f44253'
          stopBotCode: 'b_09c087e63bef0442598264fcc_8951f44253'
    getPreparedTitle: ->
      # if we have a document title, then we should use that and suffix the site's title onto it
      if @document.title
        "#{@document.title} | #{@site.title}"
      # if our document does not have it's own title, then we should just use the site's title
      else
        @site.title
  watchOptions:
    preferredMethods: ['watchFile','watch']
  plugins:
    schoolmenu:
      menuRelativeOutDirPath: "restauration/menus"
      defaultMetas :
        layout: 'menu'
        comments: true
        styles: [
          '/css/restauration.css',
          '/css/cantine-font-styles.css'
        ]
        scripts: '/js/restauration.js'
    repocloner:
      repos: [
          name: 'gssb-menus-repo'
          path: 'src/documents/restauration/menus'
          branch: 'master'
          url: 'https://github.com/apelsophiebarat/gssb-menus-repo.git'
      ]
    rss:
      collection: 'menus'
      url: '/rss.xml' # optional, this is the default
    emailobfuscator:
        emailAddresses:
            restauration: "correspondants.restauration@apelsophiebarat.net"
    #handlebars plugin configuration
    handlebarshelpers:
      helpersExtension: [
        './src/files/js/handlebars/handlebars-helpers-common',
        './src/files/js/handlebars/handlebars-helpers-docpad'
      ]
      helpers:
        isCurrentPage: (pageId, options) ->
          documentId = options.data?.document?.id
          output = if pageId is documentId then 'active' else 'inactive'
      partials:
        title: '<h1>{{document.title}}</h1>'
        goUp: '<a href="#">Scroll up</a>'
    grunt:
      docpadReady: ['bower:install']
      writeAfter: false
  collections:
    navigationPages: ->
      @getCollection("html").findAll({navigation:true},[{navigationOrder:1}])
    menus: ->
      @getCollection("documents").findAll({relativeOutDirPath: {$startsWith: 'restauration/menus'}},[basename:-1])
    menusForArchive: ->
      @getCollection("documents").findAll({relativeOutDirPath: {$startsWith: 'restauration/menus'}},[basename:-1])
      if(true)
        return @getCollection("menus")
      else
        ###
         TODO :
            dupliquer les entrees pour chaque valeur de tag
            grouper par tag
              pour chaque tag
                grouper par annees
                  pour chaque annees
                    grouper par mois
        ###
        menus = @getCollection("menus")
        separateByTagValues = (coll) ->
          output=[]
          for elem in coll
            for tag in elem.meta.tag
              output.push
                keys:
                  tag: tag
                  year: elem.meta.year
                  month: elem.meta.month
                content: elem
          return output
        menusWithKeys = separateByTagValues(menus)
        groupByTags = (coll) -> _(coll).groupBy('keys.tag').each(groupByYear).value()
        groupByYear = (coll,tag) -> _(coll).groupBy('keys.year').each(groupByMonth).value()
        groupByMonth = (coll,year) -> _.groupBy(coll,'keys.month')
        return groupByTags(menusWithKeys)








