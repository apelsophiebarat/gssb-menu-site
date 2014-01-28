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

joinArray = (array,sep=',',prefix='',suffix='',lastSep=sep) ->
      return '' unless array and array.length > 0
      array = [].concat(array)
      lastElem = array.pop()
      joinedArray = [array.join(sep),lastElem].join(lastSep)
      [prefix,joinedArray,suffix].join('')

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
      writeMeta: true
      writeAddedMeta: undefined
      query: relativeOutDirPath: $startsWith: 'restauration/menus'
      defaultMeta:
        author: 'correspondants.restauration@apelsophiebarat.net'
        layout: 'menu'
        additionalLayouts: ['menujson','menurss']
        comments: true
        styles: [
          '/css/restauration.css',
          '/css/cantine-font-styles.css'
        ]
        scripts: '/js/restauration.js'
      templateData:
        tagsForTitle: (menu) ->
          menu or= @menu
          menu.schoolLevels.join(', ')
        prepareLongTitle: (menu) ->
          menu or= @menu
          week = menu.week
          schoolLevels = joinArray(menu.schoolLevels,', ','pour ','',' et ')
          from = week.from.format('DD MMMM YYYY')
          to = week.to.format('DD MMMM YYYY')
          "Menu #{schoolLevels} de la semaine du #{from} au #{to}"
        prepareTitle: (menu) ->
          menu or= @menu
          week = menu.week
          from = week.from.format('DD MMMM YYYY')
          to = week.to.format('DD MMMM YYYY')
          "Menu pour la semaine du #{from} au #{to}"
        prepareShortTitle: (menu) ->
          menu or= @menu
          week = menu.week
          from = week.from.format('DD MMM')
          to = week.to.format('DD MMM YYYY')
          "Menu du #{from} au #{to}"
        prepareNavTitle: (menu) ->
          menu or= @menu
          week = menu.week
          from = week.from.format('DD MMM YYYY')
          to = week.to.format('DD MMM YYYY')
          "#{from} --> #{to}"
    OFFrepocloner:
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
      collection: 'menusForRss'
      url: '/rss.xml'
  collections:
    navigationPages: ->
      @getCollection("html").findAllLive(navigation:true,[navigationOrder:1])
    menus: ->
      query =
        relativeOutDirPath: $startsWith: 'restauration/menus'
        layout: 'menu'
      @getFiles(query,[basename:-1])
    menusForRss: ->
      query =
        relativeOutDirPath: $startsWith: 'restauration/menus'
        layout: 'menurss'
      @getFiles(query,[basename:-1])
    menusForToday: ->
      #collection = @getDatabase().findAllLive({relativeOutDirPath: {$startsWith: 'restauration/menus'}},[basename:-1])
      #now = moment()
      #collection.setFilter 'onlyPresentAndFuture',  (model) ->
      #  return not model.menu.week.isBeforeWeek(now)
      #return collection
      @getDatabase().findAllLive(relativeOutDirPath: $startsWith: 'restauration/menus',[basename:-1])

    menusForArchive: ->
      if(true)
        query =
          relativeOutDirPath: $startsWith: 'restauration/menus'
          layout: 'menu'
        return @getFiles(query,[basename:-1])
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







