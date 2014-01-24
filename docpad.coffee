# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
_ = require 'lodash'
moment = require 'moment'

websiteVersion = require('./package.json').version

siteUrl =
  if process.env.NODE_ENV is 'production'
    "http://www.menu.apelsophiebarat.net"
  else
    "http://localhost:9778"

module.exports =
  templateData:
    now: -> moment()
    site:
      title: "Apel Sophie Barat"
      description: "Apel Sophie Barat - Application Menu Restauration"
      url: siteUrl
      company: "Apel Sophie Barat"
      projectName: "Apel Sophie Barat"
      year: "2014"
      version: websiteVersion
      services:
        disqus: 'apelgssb'
        googleAnalytics: 'UA-45066763-2'
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
      layouts:
        rss: 'menu-rss' #unused
        html: 'menu-html' #unused
      metas:
        rss: {} #unused
        html: {} #unused
        json:
          author: 'correspondants.restauration@apelsophiebarat.net'
          layout: 'menu'
          comments: true
          styles: [
            '/css/restauration.css',
            '/css/cantine-font-styles.css'
          ]
          scripts: '/js/restauration.js'
      selector:
        query:
          relativeOutDirPath: $startsWith: 'restauration/menus'
    repocloner:
      repos: [
          name: 'gssb-menus-repo'
          path: 'src/documents/restauration/menus'
          branch: 'master'
          url: 'https://github.com/apelsophiebarat/gssb-menus-repo.git'
      ]
    emailobfuscator:
        emailAddresses:
            restauration: "correspondants.restauration@apelsophiebarat.net"
    #handlebars plugin configuration
    handlebarshelpers:
      helpersExtension: [
        './lib/handlebars-helpers-common',
        './lib/handlebars-helpers-docpad'
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
    rss:
      collection: 'menus'
      url: '/rss.xml'
  collections:
    navigationPages: ->
      @getCollection("html").findAllLive({navigation:true},[{navigationOrder:1}])
    menus: ->
      @getDatabase().findAllLive({relativeOutDirPath: {$startsWith: 'restauration/menus'}},[basename:-1])
    menusForToday: ->
      #collection = @getDatabase().findAllLive({relativeOutDirPath: {$startsWith: 'restauration/menus'}},[basename:-1])
      #now = moment()
      #collection.setFilter 'onlyPresentAndFuture',  (model) ->
      #  return not model.menu.week.isBeforeWeek(now)
      #return collection
      @getDatabase().findAllLive({relativeOutDirPath: {$startsWith: 'restauration/menus'}},[basename:-1])
    menusForArchive: ->
      if(true)
        return @getDatabase().findAllLive({relativeOutDirPath: {$startsWith: 'restauration/menus'}},[basename:-1])
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
  environments:
    development:
      templateData:
        site:
          services:
            disqus: false
            googleAnalytics: false







