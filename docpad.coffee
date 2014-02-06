# DocPad Configuration File
# http://docpad.org/docs/config

menuHelpers = require('./lib/handlebars-helpers-menu').helpers
websiteVersion = require('./package.json').version

PrepareMenu = require './lib/PrepareMenu'

siteUrl = "http://www.menu.apelsophiebarat.net" if process.env.NODE_ENV is 'production'
siteUrl or= "http://localhost:9778"

module.exports =
  templateData:
    require: (name) -> require(name)
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
      rss:
        menu:
          title: 'menus'
          url: '/rss.xml'
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
    coffeekup:
      require: (name) -> require(name)
      hardcode:
        require: (name) -> require(name)
    schoolmenu:
      query:
        relativeOutDirPath:
          $startsWith: 'restauration/menus'
      defaultMeta:
        author: 'correspondants.restauration@apelsophiebarat.net'
        layout: 'menu/default'
        additionalLayouts: ['menu/json','menu/rss']
        comments: true
        styles: [
          '/css/restauration.css',
          '/css/cantine-font-styles.css'
        ]
        scripts: '/js/restauration.js'
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
    handlebarshelpers:
      useTemplateDataFunctions: false
      extensions: [
        './lib/handlebars-helpers-common',
        './lib/handlebars-helpers-docpad',
        './lib/handlebars-helpers-menu'
      ]
    handlebars:
      helpers:
        prepareMenu: (menu,options) -> PrepareMenu.prepare(menu,options)
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
      default:
        collection: 'menusForRss'
        url: '/rss.xml'
        item:
          description: (document) -> document.contentRendered
  collections:
    navigationPages: ->
      @getCollection("html").findAllLive(navigation:true,[navigationOrder:1])
    menus: ->
      query =
        relativeOutDirPath:
          $startsWith: 'restauration/menus'
        layout: 'menu/default'
      @getCollection("html").findAllLive(query,[basename:-1])
    menusForRss: ->
      query =
        relativeOutDirPath:
          $startsWith: 'restauration/menus'
        layout: 'menu/rss'
      #@getFiles(query,[basename:-1])
      @getCollection("html").findAllLive(query,[basename:-1])
  environments:
    development:
      templateData:
        site:
          services:
            disqus: false
            googleAnalytics: false







